--  ______     ______   ______      ______     ______        __    __     ______     ______   __  __     __     ______     ______    
-- /\  ___\   /\__  _\ /\  == \    /\  __ \   /\  ___\      /\ "-./  \   /\  __ \   /\__  _\ /\ \_\ \   /\ \   /\  __ \   /\  ___\   
-- \ \___  \  \/_/\ \/ \ \  _-/    \ \ \/\ \  \ \ \__ \     \ \ \-./\ \  \ \  __ \  \/_/\ \/ \ \  __ \  \ \ \  \ \  __ \  \ \___  \  
--  \/\_____\    \ \_\  \ \_\       \ \_____\  \ \_____\     \ \_\ \ \_\  \ \_\ \_\    \ \_\  \ \_\ \_\  \ \_\  \ \_\ \_\  \/\_____\ 
--   \/_____/     \/_/   \/_/        \/_____/   \/_____/      \/_/  \/_/   \/_/\/_/     \/_/   \/_/\/_/   \/_/   \/_/\/_/   \/_____/ 
--                                                                             

resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

-- Bil data
files {
    't6indsats.xml',
    'vehicles.meta',
    'carvariations.meta',
    'carcols.meta',
    'handling.meta',
}

-- Bil data finder
data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'

-- ELS+
is_els 'true'