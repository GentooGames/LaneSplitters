
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______  ______   ______  //
	// /\  ___\ /\__  _\/\  __ \ /\__  _\ //
	// \ \___  \\/_/\ \/\ \  __ \\/_/\ \/ //
	//  \/\_____\  \ \_\ \ \_\ \_\  \ \_\ //
	//   \/_____/   \/_/  \/_/\/_/   \/_/ //
	//                                    //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_Stat(_config = {}) constructor {
		
		#region [info]
	
		#region overview
		/*
			IB_Stat() is an encapsulation for variable members 
			used specifically for tracking what could be
			considered a "stat", such as: life, attack, speed,
			defense, stamina, etc. these stats are often times
			needing to be modified in-real-time to reflect 
			modifications granted by items or abilities. these
			modifications may buff the stat and make is stronger,
			or nerf the stat making it weaker.
		
			IB_Stat() is an extansion of IB_Stat(), 
			meaning that it contains some sort of adjusting
			value; however, IB_Stat() is designed
			specifically to take a series of stat mods, such
			as buffs and/or debuffs. if a stat value may be
			influenced by any number of modifications over 
			its lifetime, then a modifiable stat is what 
			should be used.
		
			this stat mod automatically hooks into iceberg's 
			begin_step update, so the user does not need to 
			manually invoke any update on the stat mod itself.
		*/
		#endregion
		#region features
		/*
			limits
				this IB_Stat() class supports the ability to define
				an upper and/or lower limit, that will automatically
				be applied when get() is invoked. if these limits 
				are not set, then they will not be applied, and the 
				raw value will be returned when get() is called.
				keep in mind that if value is accessed directly as 
				a member, and not accessed through the get() method,
				then the limit will not be applied and the raw value
				will be returned only.
		
			mods
				this is the core of the modifiable stat. a set
				of mods that are applied to the stat. a mod can
				either be linear or scalar.
					linear
						linear mods will apply a single addition
						or subtraction value to the base value

					scalar
						scalar mods will apply a multiplicitive
						value to the base value. this multiplication
						can be defined as either "relative" or 
						"absolute".
					
						relative 
							scalar value will be a multiplcattion 
							of the stats current value. 
					
						absolute 
							scalar value will be a multiplcattion 
							of the stats base value, and will not 
							account for any other modifications
							already applied to the stat.
			
			override
				if override is set, then all other modifications 
				will be ignored and only the override will be 
				accounted for in the get() method. KEEP IN MIND 
				that this override value will only be accounted 
				for if the stat's value is retreived specifically 
				through the defined get() method. reading the raw 
				value directly will not account for the override.
		*/
		#endregion
		#region config
		/*
			<bool> limit_apply	(optional : default = true)
			<real> limit_max	(optional : default = undefined)
			<real> limit_min	(optional : default = undefined)
			<real> value		(optional : default = 0)
			<real> override		(optional : default = undefined)
		*/
		#endregion
		#region example
		/*
			health = new IB_Stat({
				value:	   100,
				limit_min: 0,
				limit_max: 100,
			}).initialize();
		
			// create new attack_cooldown_time stat
			attack_cooldown_time = new IB_Stat({
				value: room_speed * 3, // three second cooldown
			});
		
			// add a linear modifier to the attack_cooldown_time stat
			attack_cooldown_time.new_mod_linear("agility_buff", {
				value: -10, // decreases attack cooldown by 10 frames
			});
		
			// remove modifier
			attack_cooldown_time.remove_mod("agility_buff");
		
			// ^ this will remove all instances of agility_buff that
			// is currently applied to the attack_cooldown_time stat. if 
			// multiple buff instances are applied, and an individual
			// stat should be removed, you can pass in the instance
			// as the second parameter to ensure that instance
			// specifically is removed. 
		*/
		#endregion
	
		#endregion
		
		var _self  = self;
		var _owner = other;
		
		// public
		static get					 = function() {
			// check for hard override 
			if (__.override != undefined) {
				return __.override;	
			}
			// check for mod override
			if (__.modifiers_override != undefined) {
				return __.modifiers_override;
			};
			// get standard moded value
			var _value  = __get_mod_sum(__.value);
			if (_value !=   undefined) {
				_value  = __limit(_value);
			}
			return _value;
		};
		static set					 = function(_value, _limit_apply = get_limit_apply()) {
			__.previous = __.value;
			if (_limit_apply) {
				 __.value = __limit(_value);
			}
			else __.value = _value;
			return self;
		};
		static restore				 = function() {
			set(__.value_start, false);
			return self;
		};
		static add					 = function(_amount, _limit_apply = get_limit_apply()) {
			set(__.value + _amount, _limit_apply);
			return self;
		};
		static subtract				 = function(_amount, _limit_apply = get_limit_apply()) {
			set(__.value - _amount, _limit_apply);
			return self;
		};
									 
		static get_limit_apply		 = function() {
			return __.limit_apply;
		};
		static get_limit_max		 = function() {
			return __.limit_max;
		};
		static get_limit_min		 = function() {
			return __.limit_min;
		};
		static set_limit_apply		 = function(_limit_apply) {
			__.limit_apply = _limit_apply;
			return self;
		};
		static set_limit_max		 = function(_limit_max) {
			__.limit_max = _limit_max;
			return self;
		};
		static set_limit_min		 = function(_limit_min) {
			__.limit_min = _limit_min;
			return self;
		};
			
		static modifier_new_additive = function(_modifier_name, _value, _duration = -1, _cost = 1) {
			var _modifier = new __IB_StatModifier_Additive({
				name:	  _modifier_name,
				value:	  _value,
				duration: _duration, 
				cost:	  _cost,
			});
			__.modifiers.add(_modifier_name, _modifier);
			return _modifier;
		};
		static modifier_new_scalar	 = function(_modifier_name, _value, _duration = -1, _cost = 0, _relative = false, _base = undefined) {
			var _modifier = new __IB_StatModifier_Scalar({
				name:	  _modifier_name,
				value:	  _value,
				duration: _duration, 
				cost:	  _cost,	
				relative: _relative,
				base:	  _base,
			});
			__.modifiers.add(_modifier_name, _modifier);
			return _modifier;
		};
		static modifier_new_override = function(_modifier_name, _value, _duration = -1, _cost = 1) {
			var _modifier = new __IB_StatModifier_Override({
				name:	  _modifier_name,
				value:	  _value,
				duration: _duration, 
				cost:	  _cost,	
			});
			__.modifiers.add(_modifier_name, _modifier);
			return _modifier;
		};
		static modifier_remove		 = function(_modifier_name, _modifier_instance = undefined) {
			// remove all modifier instances of type: "modifier_name"
			if (_modifier_instance == undefined) {
				__.modifiers.remove(_modifier_name);	
			}
			// remove specific modifier instance of type: "modifier_name"
			else {
				__.modifiers.remove(_modifier_name, _modifier_instance);
			}
			return self;
		};
		static modifier_get			 = function(_modifier_name) {
			return __.modifiers.get(_modifier_name);	
		};
		static modifiers_get		 = function() {
			return __.modifiers.get_items();
		};
			
		static override_get			 = function() {
			return __.override;
		};
		static override_set			 = function(_override) {
			__.override = _override;
			return self;
		};
		static override_remove		 = function() {
			__.override = undefined;
			return self;
		};
	
		// private
		__ = {};
		with (__) {
			static __limit			= function(_value) {
				if (__.limit_min != undefined && __.limit_max != undefined) {
					return clamp(_value, __.limit_min, __.limit_max);	
				}
				else if (__.limit_min != undefined && __.limit_max == undefined) {
					return max(_value, __.limit_min);	
				}
				else if (__.limit_min == undefined && __.limit_max != undefined) {
					return min(_value, __.limit_max);	
				}
				return _value;
			};
			static __get_mod_sum	= function(_value) {
				if (_value != undefined) {
					return _value + __.modifiers_sum;
				}
				return _value;
			};
			static __update_mod_sum = function() {
				__.modifiers_sum	  = 0;
				__.modifiers_override = undefined;
			
				for (var _i = 0, _len_i = __.modifiers.get_size(); _i < _len_i; _i++) {
					var _name = __.modifiers.get_name(_i);
					var _mods = __.modifiers.get_items(_name);
			
					// mod may complete on tick(), which would remove it 
					// from the array. iterate through array backwards to 
					// avoid index-out-of-bounds.
					for (var _j = array_length(_mods) - 1; _j >= 0; _j--) {
						var _mod = _mods[_j];
						
						if (_mod.get_type() == "override") {
							__.modifiers_override = _mod.get();
						}
						__.modifiers_sum += _mod.get();
						
						_mod.tick();
					};
				};
			};
		
			initialized		   = _config[$ "initialized"] ??  false;
			active			   = _config[$ "active"		] ??  true;
			owner			   = _config[$ "owner"		] ?? _owner;
			
			value			   = _config[$ "value"	    ] ??  undefined;
			value_start		   = _config[$ "value_start"] ??  value;
			limit_min		   = _config[$ "limit_min"  ] ??  undefined;
			limit_max		   = _config[$ "limit_max"  ] ??  undefined;
			limit_apply		   = _config[$ "limit_apply"] ??  true;
			override		   = _config[$ "override"	] ??  undefined;
			
			modifiers		   = new IB_Collection_Set();
			modifiers_sum	   = 0;
			modifiers_override = undefined;
			previous		   = undefined;
		};
			
		// events
		static initialize = function() {
			__.initialized = true;
			return self;
		};
		static activate   = function() {
			__.active = true;
			return self;
		};
		static deactivate = function() {
			__.active = false;
			return self;
		};
		static update	  = function() {
			if (__.initialized && __.active) {
				__update_mod_sum();
			}
			return self;
		};
		static cleanup	  = function() {
			// compatibility ...
		};
	};
	