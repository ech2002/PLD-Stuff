-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('Motenten-Globals.lua')
	include('organizer-lib')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
	state.Buff['Aftermath'] = buffactive['Aftermath: Lv.1'] or
    buffactive['Aftermath: Lv.2'] or
    buffactive['Aftermath: Lv.3'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'BDT', 'Fodder', 'Acc', 'DW')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'Skillchain', 'HP', 'Reraise', 'DPSPDT')
    state.MagicalDefenseMode:options('MDT', 'HP', 'Reraise', 'Charm')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')

    update_defense_mode()
    
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
    send_command('bind @f10 gs c toggle EquipShield')
    send_command('bind @f11 gs c toggle EquipShield')

	send_command('bind sysrq screenshot png hide')
	send_command('bind ^v paste')	
	
    select_default_macro_book(4)
end


function user_unload()
    send_command('clearbinds')

	
end


-- Define sets and vars used by this job file.
function init_gear_sets()

organizer_items = {
  echos="Echo Drops",
  remedy="Remedy",
  curry="Red Curry","Red Curry Bun",
  sushi="Sublime Sushi",
  capring="Capacity Ring",
  triring="Trizek Ring",
}
    --------------------------------------
    -- Precast sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = {legs="Caballarius Breeches +1"}
    sets.precast.JA['Holy Circle'] = {feet="Chev. Sabatons +1"}
    sets.precast.JA['Shield Bash'] = {hands="Caballarius Gauntlets +1"}
    sets.precast.JA['Sentinel'] = {feet="Caballarius Leggings +1"}
    sets.precast.JA['Rampart'] = {head="Caballarius Coronet +1"}
    sets.precast.JA['Fealty'] = {body="Caballarius Surcoat +1"}
    sets.precast.JA['Divine Emblem'] = {feet="Chev. Sabatons +1"}
    sets.precast.JA['Cover'] = {head="Reverence Coronet +1"}

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {hands="Caballarius Gauntlets +1"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
	ammo="Sapience Orb",
    head="Reverence Coronet +1",
    body="Caballarius surcoat +1",
    hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    legs="Caballarius breeches +1",
    feet={ name="Souveran Schuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    neck="Diemer Gorget",
    waist="Flume Belt",
    left_ear="Oneiros Earring",
    right_ear="Ethereal Earring",
    left_ring="Moonbeam Ring",
    right_ring="Sulevia's Ring",
    back="Moonbeam Cape",
}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {
	ammo="Sapience Orb",
    head="Reverence Coronet +1",
    body="Caballarius surcoat +1",
    hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    legs="Caballarius breeches +1",
    feet={ name="Souveran Schuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    neck="Diemer Gorget",
    waist="Flume Belt",
    left_ear="Oneiros Earring",
    right_ear="Ethereal Earring",
    left_ring="Moonbeam Ring",
    right_ring="Sulevia's Ring",
    back="Moonbeam Cape",
}
    
    sets.precast.Step = {
    ammo="Sapience Orb",
    head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
    body={ name="Emicho Haubert", augments={'HP+50','DEX+10','Accuracy+15',}},
    hands={ name="Emicho Gauntlets", augments={'HP+50','DEX+10','Accuracy+15',}},
    legs={ name="Odyssean Cuisses", augments={'Accuracy+25 Attack+25','"Cure" potency +1%','STR+10','Accuracy+12','Attack+15',}},
    feet={ name="Valorous Greaves", augments={'Accuracy+25 Attack+25','"Dbl.Atk."+3','Accuracy+3',}},
    neck="Asperity Necklace",
    waist="Windbuffet Belt",
    left_ear="Heartseeker Earring",
    right_ear="Steelflash Earring",
    left_ring="Patricius Ring",
    right_ring="Defending Ring",
    back="Ground. Mantle +1",
}
	
    sets.precast.Flourish = {
	ammo="Sapience Orb",
    head="Reverence Coronet +1",
    body="Caballarius surcoat +1",
    hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    legs="Caballarius breeches +1",
    feet={ name="Souveran Schuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    neck="Diemer Gorget",
    waist="Flume Belt",
    left_ear="Oneiros Earring",
    right_ear="Ethereal Earring",
    left_ring="Moonbeam Ring",
    right_ring="Sulevia's Ring",
    back="Moonbeam Cape",
}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
    ammo="Incantor Stone",
    head="Reverence coronet +1",
    body="Caballarius surcoat +1",
    hands={ name="Leyline Gloves", augments={'Accuracy+6','Mag. Acc.+2','"Mag.Atk.Bns."+6',}},
    legs={ name="Odyssean Cuisses", augments={'"Fast Cast"+4','Mag. Acc.+12 "Mag.Atk.Bns."+12','Phalanx +2',}},
    feet="Odyssean Greaves",
    neck="Orunmila's Torque",
    waist="Creed Baudrier",
    left_ear="Enchntr. Earring +1",
    right_ear="Loquac. Earring",
    left_ring="Patricius Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",
}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
    ammo="Vanir Battery",
    head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
    body={ name="Odyss. Chestplate", augments={'Accuracy+22 Attack+22','"Dbl.Atk."+3','STR+9','Accuracy+3',}},
    hands={ name="Odyssean Gauntlets", augments={'Accuracy+29','Weapon skill damage +4%','DEX+10','Attack+5',}},
    legs={ name="Odyssean Cuisses", augments={'Accuracy+25 Attack+25','"Cure" potency +1%','STR+10','Accuracy+12','Attack+15',}},
    feet={ name="Valorous Greaves", augments={'Accuracy+25 Attack+25','"Dbl.Atk."+3','Accuracy+3',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Brutal Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
    left_ring="Ifrit Ring +1",
    right_ring="Ifrit Ring +1",
    back="Atheling Mantle",
}

    sets.precast.WS.Acc = {
    ammo="Vanir Battery",
    head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
    body={ name="Odyss. Chestplate", augments={'Accuracy+22 Attack+22','"Dbl.Atk."+3','STR+9','Accuracy+3',}},
    hands={ name="Odyssean Gauntlets", augments={'Accuracy+29','Weapon skill damage +4%','DEX+10','Attack+5',}},
    legs={ name="Odyssean Cuisses", augments={'Accuracy+25 Attack+25','"Cure" potency +1%','STR+10','Accuracy+12','Attack+15',}},
    feet={ name="Valorous Greaves", augments={'Accuracy+25 Attack+25','"Dbl.Atk."+3','Accuracy+3',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Brutal Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
    left_ring="Ifrit Ring +1",
    right_ring="Ifrit Ring +1",
    back="Atheling Mantle",
}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ring1="Leviathan Ring +1"})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {ring1="Leviathan Ring +1"})

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {ring1="Ramuh Ring +1",ring2="Ramuh Ring"})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {back="Weard Mantle"})
	
	sets.precast.WS['Knights of Round'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Savage Blade'] = {
    ammo="Vanir Battery",
    head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
    body={ name="Odyss. Chestplate", augments={'Accuracy+22 Attack+22','"Dbl.Atk."+3','STR+9','Accuracy+3',}},
    hands={ name="Odyssean Gauntlets", augments={'Accuracy+29','Weapon skill damage +4%','DEX+10','Attack+5',}},
    legs={ name="Odyssean Cuisses", augments={'Accuracy+25 Attack+25','"Cure" potency +1%','STR+10','Accuracy+12','Attack+15',}},
    feet={ name="Valorous Greaves", augments={'Accuracy+25 Attack+25','"Dbl.Atk."+3','Accuracy+3',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Brutal Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
    left_ring="Ifrit Ring +1",
    right_ring="Ifrit Ring +1",
    back="Atheling Mantle",
}

    sets.precast.WS['Sanguine Blade'] = {
	ammo="Dosis Tathlum",
    head={ name="Jumalik Helm", augments={'MND+10','"Mag.Atk.Bns."+15','Magic burst mdg.+10%','"Refresh"+1',}},
    body={ name="Jumalik Mail", augments={'HP+50','Attack+15','Enmity+9','"Refresh"+2',}},
    hands={ name="Founder's Gauntlets", augments={'STR+10','Attack+15','"Mag.Atk.Bns."+15','Phys. dmg. taken -5%',}},
    legs={ name="Souveran Diechlings", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    feet={ name="Founder's Greaves", augments={'VIT+9','"Mag.Atk.Bns."+12','Mag. Evasion+9',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Friomisi Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
    left_ring="Fenrir Ring +1",
    right_ring="Fenrir Ring +1",
    back="Toro Cape",
}
    
    sets.precast.WS['Atonement'] = {
    ammo="Sapience Orb",
    head={ name="Reverence Coronet +1", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    body="Phorcys Korazin",
    hands={ name="Odyssean Gauntlets", augments={'Accuracy+29','Weapon skill damage +4%','DEX+10','Attack+5',}},
    legs={ name="Souveran Diechlings", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    feet={ name="Souveran Schuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Friomisi Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
    left_ring="Apeile Ring +1",
    right_ring="Defending Ring",
    back="Agema Cape",
}
    
    sets.precast.Cure = {
    ammo="Incantor Stone",
    head="Rev. Coronet +1",
    body={ name="Cab. Surcoat +1", augments={'Enhances "Fealty" effect',}},
    hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    legs={ name="Cab. Breeches +1", augments={'Enhances "Invincible" effect',}},
    feet={ name="Souveran Schuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    neck="Diemer Gorget",
    waist="Flume Belt",
    left_ear="Nourish. Earring",
    right_ear="Mendicant's Earring",
    left_ring="Moonbeam Ring",
    right_ring="Sulevia's Ring",
    back="Moonbeam Cape",
}
		
		
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
    ammo="Incantor Stone",
    head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
    body={ name="Odyss. Chestplate", augments={'MND+10','CHR+5','"Fast Cast"+3','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
    hands={ name="Reverence Gauntlets +1"},
    legs={ name="Odyssean Cuisses", augments={'"Fast Cast"+4','Mag. Acc.+12 "Mag.Atk.Bns."+12','Phalanx +2',}},
    feet="Odyssean Greaves",
    neck="Orunmila's Torque",
    waist="Flume Belt",
    left_ear="Mendi. Earring",
    right_ear="Loquac. Earring",
    left_ring="Moonbeam Ring",
    right_ring="Sulevia's Ring",
    back="Moonbeam Cape",
}
        
    sets.midcast.Enmity = {
    ammo="Sapience Orb",
    head={ name="Cab. Coronet +1", augments={'Enhances "Iron Will" effect',}},
    body="Reverence surcoat +1",
    hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
	legs={ name="Cab. Breeches +1", augments={'Enhances "Invincible" effect',}},
    feet={ name="Souveran Schuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    neck="Twilight Torque",
    waist="Creed Baudrier",
    left_ear="Friomisi Earring",
    right_ear="Ethereal Earring",
    left_ring="Moonbeam Ring",
    right_ring="Sulevia's Ring",
    back="Weard Mantle",
}

    sets.midcast.Flash = set_combine(sets.midcast.Enmity, {})
    
    sets.midcast.Stun = sets.midcast.Flash
	
	sets.midcast.Provoke = sets.midcast.Flash
	
	sets.midcast['Blue Magic'] = set_combine(sets.midcast.Enmity, {})
	
	sets.midcast['Blue Magic']['Wild Carrot'] = set_combine(sets.midcast.Enmity, sets.midcast.Cure)
	    
    sets.midcast.Cure = {
    ammo="Incantor Stone",
    head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
    body={ name="Jumalik Mail", augments={'HP+50','Attack+15','Enmity+9','"Refresh"+2',}},
    hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    legs={ name="Souveran Diechlings", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    feet={ name="Souveran Schuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    neck="Diemer Gorget",
    waist="Creed Baudrier",
    left_ear="Nourish. Earring",
    right_ear="Mendicant's Earring",
    left_ring="Moonbeam Ring",
    right_ring="Sulevia's Ring",
    back="Moonbeam Cape",
}
		
	sets.midcast.Enlight = {
    ammo="Incantor Stone",
    head={ name="Jumalik Helm", augments={'MND+10','"Mag.Atk.Bns."+15','Magic burst mdg.+10%','"Refresh"+1',}},
    body={ name="Reverence surcoat +1", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    hands="Eschite Gauntlets",
    legs={ name="Odyssean Cuisses", augments={'"Fast Cast"+4','Mag. Acc.+12 "Mag.Atk.Bns."+12','Phalanx +2',}},
    feet={ name="Souveran Schuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    neck="Inquisitor's Chain",
    waist="Asklepian Belt",
    left_ear="Friomisi Earring",
    right_ear="Ethereal Earring",
    left_ring="Begrudging Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",
}

    sets.midcast['Enhancing Magic'] = {
    ammo="Incantor Stone",
    head={ name="Jumalik Helm", augments={'MND+10','"Mag.Atk.Bns."+15','Magic burst mdg.+10%','"Refresh"+1',}},
    body={ name="Reverence surcoat +1", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    hands="Eschite Gauntlets",
    legs={ name="Odyssean Cuisses", augments={'"Fast Cast"+4','Mag. Acc.+12 "Mag.Atk.Bns."+12','Phalanx +2',}},
    feet={ name="Souveran Schuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    neck="Twilight Torque",
    waist="Asklepian Belt",
    left_ear="Friomisi Earring",
    right_ear="Ethereal Earring",
    left_ring="Begrudging Ring",
    right_ring="Defending Ring",
    back={ name="Weard Mantle", augments={'VIT+2','DEX+3','Enmity+4','Phalanx +4',}},
}

    sets.midcast.Phalanx = {
    ammo="Incantor Stone",
    head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
    body={ name="Reverence surcoat +1", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    legs={ name="Odyssean Cuisses", augments={'"Fast Cast"+4','Mag. Acc.+12 "Mag.Atk.Bns."+12','Phalanx +2',}},
    feet={ name="Souveran Schuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    neck="Twilight Torque",
    waist="Asklepian Belt",
    left_ear="Friomisi Earring",
    right_ear="Ethereal Earring",
    left_ring="Begrudging Ring",
    right_ring="Defending Ring",
    back={ name="Weard Mantle", augments={'VIT+2','DEX+3','Enmity+4','Phalanx +4',}},
}
    
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.Reraise = {head="Loess Barbuta +1", body="Rev. Surcoat +1"}
    
    sets.resting = {neck="Loricate Torque"}
    

    -- Idle sets
    sets.idle = {
    ammo="Angha Gem",
    head="Rev. Coronet +1",
    body={ name="Cab. Surcoat +1", augments={'Enhances "Fealty" effect',}},
    hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    legs={ name="Souveran Diechlings", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    feet={ name="Souveran Schuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    neck="Twilight Torque",
    waist="Flume Belt",
    left_ear="Etiolation Earring",
    right_ear="Ethereal Earring",
    left_ring="Moonbeam Ring",
    right_ring="Sulevia's Ring",
    back="Moonbeam Cape",
}


    sets.idle.Town = {
    main={ name="Colada", augments={'"Dbl.Atk."+3','VIT+11','Accuracy+18','Attack+19','DMG:+9',}},
    sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
    ammo="Angha Gem",
    head="Reverence Coronet +1",
    body={ name="Cab. Surcoat +1", augments={'Enhances "Fealty" effect',}},
    hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    legs={ name="Cab. Breeches +1", augments={'Enhances "Invincible" effect',}},
    feet={ name="Souveran Schuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    neck="Twilight Torque",
    waist="Flume Belt",
    left_ear="Oneiros Earring",
    right_ear="Ethereal Earring",
    left_ring="Warp Ring",
    right_ring="Moonbeam Ring",
    back="Moonbeam Cape",
}
    
    sets.idle.Weak = {
    main={ name="Colada", augments={'"Dbl.Atk."+3','VIT+11','Accuracy+18','Attack+19','DMG:+9',}},
    sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
    ammo="Angha Gem",
    head="Reverence Coronet +1",
    body={ name="Cab. Surcoat +1", augments={'Enhances "Fealty" effect',}},
    hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    legs={ name="Cab. Breeches +1", augments={'Enhances "Invincible" effect',}},
    feet={ name="Souveran Schuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    neck="Twilight Torque",
    waist="Flume Belt",
    left_ear="Oneiros Earring",
    right_ear="Ethereal Earring",
    left_ring="Moonbeam Ring",
    right_ring="Sulevia's Ring",
    back="Moonbeam Cape",
}
    
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
    
    sets.Kiting = {ring1="Shneddick Ring"}

    sets.latent_refresh = {waist="Fucho-no-obi"}


    --------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {back="Repulse Mantle"}
    sets.MP = {neck="Creed Collar",waist="Flume Belt"}
    sets.MP_Knockback = {neck="Creed Collar",waist="Flume Belt",back="Repulse Mantle"}
    
    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {main={ name="Colada", augments={'"Dbl.Atk."+3','VIT+11','Accuracy+18','Attack+19','DMG:+9',}},sub="Priwen"} -- Priwen
    sets.walShield = {main={ name="Colada", augments={'"Dbl.Atk."+3','VIT+11','Accuracy+18','Attack+19','DMG:+9',}},sub="Beatific Shield +1"} -- Beatific Shield +1

    -- Basic defense sets.
        
    sets.defense.PDT = {main={ name="Colada", augments={'"Dbl.Atk."+3','VIT+11','Accuracy+18','Attack+19','DMG:+9',}},
    sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
    ammo="Sapience Orb",
    head="Rev. Coronet +1",
    body={ name="Cab. Surcoat +1", augments={'Enhances "Fealty" effect',}},
    hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    legs={ name="Cab. Breeches +1", augments={'Enhances "Invincible" effect',}},
    feet={ name="Souveran Schuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    neck="Diemer Gorget",
    waist="Flume Belt",
    left_ear="Oneiros Earring",
    right_ear="Ethereal Earring",
    left_ring="Moonbeam Ring",
    right_ring="Sulevia's Ring",
    back="Rudianos's Mantle",
}

	sets.defense.Skillchain = {}
    sets.defense.HP = {}
    sets.defense.Reraise = {}
    sets.defense.DPSPDT = {}
    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
	
    sets.defense.MDT = {main={ name="Colada", augments={'"Dbl.Atk."+3','VIT+11','Accuracy+18','Attack+19','DMG:+9',}},
    sub="Beatific Shield +1",
    ammo="Angha Gem",
    head="Rev. Coronet +1",
    body={ name="Cab. Surcoat +1", augments={'Enhances "Fealty" effect',}},
    hands="Rev. Gauntlets +1",
    legs={ name="Cab. Breeches +1", augments={'Enhances "Invincible" effect',}},
    feet={ name="Souveran Schuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    neck="Twilight Torque",
    waist="Flume Belt",
    left_ear="Oneiros Earring",
    right_ear="Ethereal Earring",
    left_ring="Moonbeam Ring",
    right_ring="Sulevia's Ring",
    back="Moonbeam Cape",
}

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    sets.engaged = {main={ name="Colada", augments={'"Dbl.Atk."+3','VIT+11','Accuracy+18','Attack+19','DMG:+9',}},
    sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
    ammo="Sapience Orb",
    head="Rev. Coronet +1",
    body={ name="Cab. Surcoat +1", augments={'Enhances "Fealty" effect',}},
    hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    legs={ name="Cab. Breeches +1", augments={'Enhances "Invincible" effect',}},
    feet={ name="Souveran Schuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    neck="Diemer Gorget",
    waist="Flume Belt",
    left_ear="Oneiros Earring",
    right_ear="Ethereal Earring",
    left_ring="Moonbeam Ring",
    right_ring="Sulevia's Ring",
    back="Moonbeam Cape",
}
	
	sets.engaged.BDT = {main={ name="Colada", augments={'"Dbl.Atk."+3','VIT+11','Accuracy+18','Attack+19','DMG:+9',}},
    sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
    ammo="Sapience Orb",
    head={ name="Reverence Coronet +1", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    body={ name="Reverence surcoat +1", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    legs={ name="Souveran Diechlings", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    feet={ name="Souveran Schuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    neck="Twilight Torque",
    waist="Flume Belt",
    left_ear="Friomisi Earring",
    right_ear="Ethereal Earring",
    left_ring="Patricius Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",
}	
		
    sets.engaged.Fodder = {main={ name="Colada", augments={'"Dbl.Atk."+3','VIT+11','Accuracy+18','Attack+19','DMG:+9',}},
    sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
    ammo="Sapience Orb",
    head="Rev. Coronet +1",
    body={ name="Cab. Surcoat +1", augments={'Enhances "Fealty" effect',}},
    hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    legs={ name="Cab. Breeches +1", augments={'Enhances "Invincible" effect',}},
    feet={ name="Souveran Schuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    neck="Diemer Gorget",
    waist="Flume Belt",
    left_ear="Oneiros Earring",
    right_ear="Ethereal Earring",
    left_ring="Moonbeam Ring",
    right_ring="Sulevia's Ring",
    back="Moonbeam Cape",
}
		
    sets.engaged.Acc = {main={ name="Colada", augments={'"Dbl.Atk."+3','VIT+11','Accuracy+18','Attack+19','DMG:+9',}},
    sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
    ammo="Sapience Orb",
    head="Rev. Coronet +1",
    body={ name="Cab. Surcoat +1", augments={'Enhances "Fealty" effect',}},
    hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    legs={ name="Cab. Breeches +1", augments={'Enhances "Invincible" effect',}},
    feet={ name="Souveran Schuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    neck="Diemer Gorget",
    waist="Flume Belt",
    left_ear="Oneiros Earring",
    right_ear="Ethereal Earring",
    left_ring="Moonbeam Ring",
    right_ring="Sulevia's Ring",
    back="Moonbeam Cape",
}

    sets.engaged.DW = {main={ name="Colada", augments={'"Dbl.Atk."+3','VIT+11','Accuracy+18','Attack+19','DMG:+9',}},
    sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
    ammo="Sapience Orb",
    head="Rev. Coronet +1",
    body={ name="Cab. Surcoat +1", augments={'Enhances "Fealty" effect',}},
    hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    legs={ name="Cab. Breeches +1", augments={'Enhances "Invincible" effect',}},
    feet={ name="Souveran Schuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    neck="Diemer Gorget",
    waist="Flume Belt",
    left_ear="Oneiros Earring",
    right_ear="Ethereal Earring",
    left_ring="Moonbeam Ring",
    right_ring="Sulevia's Ring",
    back="Moonbeam Cape",
}

    sets.engaged.DW.Acc = {main={ name="Colada", augments={'"Dbl.Atk."+3','VIT+11','Accuracy+18','Attack+19','DMG:+9',}},
    sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
    ammo="Sapience Orb",
    head="Rev. Coronet +1",
    body={ name="Cab. Surcoat +1", augments={'Enhances "Fealty" effect',}},
    hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    legs={ name="Cab. Breeches +1", augments={'Enhances "Invincible" effect',}},
    feet={ name="Souveran Schuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    neck="Diemer Gorget",
    waist="Flume Belt",
    left_ear="Oneiros Earring",
    right_ear="Ethereal Earring",
    left_ring="Moonbeam Ring",
    right_ring="Sulevia's Ring",
    back="Moonbeam Cape",
}

    sets.engaged.PDT = set_combine(sets.engaged, {})
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {})
    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)

    sets.engaged.DW.PDT = set_combine(sets.engaged.DW, {})
    sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.DW.Acc, {})
    sets.engaged.DW.Reraise = set_combine(sets.engaged.DW, sets.Reraise)
    sets.engaged.DW.Acc.Reraise = set_combine(sets.engaged.DW.Acc, sets.Reraise)


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Doom = {ring1="Purity Ring",ring2="Saida Ring"}
    sets.buff.Cover = {}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    if state.EquipShield.value == true then
        classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    end

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    
    return meleeSet
end

function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
    
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
    
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end
    
    return defenseSet
end


function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.ExtraDefenseMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
    end
    
    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()
    if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
        classes.CustomDefenseGroups:append('Kheshig Blade')
    end
    
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Priwen' and player.equipment.sub ~= 'Ochain' then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 7)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 7)
    elseif player.sub_job == 'RUN' then
        set_macro_page(10, 7)
    else
        set_macro_page(1, 7)
    end
end

---------------- Rieve Mark Neck Auto Equip ------------------

function job_buff_change(buff, gain)
    if buff == 'Reive Mark' then
        handle_equipping_gear(player.status)
    end
end

function customize_melee_set(melee_set)
    if buffactive['reive mark'] then
        melee_set = set_combine(melee_set, {neck="Arciela's Grace +1"})
    end
    return melee_set
end

function customize_idle_set(idle_set)
    if buffactive['reive mark'] then
        idle_set = set_combine(idle_set, {neck="Arciela's Grace +1"})
    end
    return idle_set
end


-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff == "Aftermath: Lv.3" or buff == "Aftermath" then
		classes.CustomMeleeGroups:clear()
		if (buff == "Aftermath: Lv.3" and gain) or buffactive["Aftermath: Lv.3"] then
				if gain then
					send_command('timers create "Aftermath: Lv.3" 180 down;wait 120;input /echo Aftermath: Lv.3 [WEARING OFF IN 60 SEC.];wait 30;input /echo Aftermath: Lv.3 [WEARING OFF IN 30 SEC.];wait 20;input /echo Aftermath: Lv.3 [WEARING OFF IN 10 SEC.]')
				else
					send_command('timers delete "Aftermath: Lv.3"')
                    add_to_chat(123,'AM3: [OFF]')
				end
		end
	end	
end		


------------------------------------------------------------------------






