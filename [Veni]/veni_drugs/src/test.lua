--made by cyclops
local dumper_s = {
   inpfile = 'todump.lua';
   outfile = 'constdmp.log';
};

local r = readfile(dumper_s.inpfile);
local sig = assert(r:match('(%a%[%a%])%s-=%s-%b()[\r\n;]'), '[cons dumper] : couldnt grab first'); --match for later
local save_hook = ('writefile(%q, cons);warn(\'Flushed onto outfile, took\32\' .. %s .. \'\32seconds.\');');
sig = sig:gsub('[%[%]]', '%%%1');
r = r:gsub(('(%s%%s-=%%s-(%%a)[\r\n;])'):format(sig), 'cons = cons.. %2.. \'\\n\';\32%1');
r = r:gsub('return%s-%(?function%(%.+%).-end%)', 'return (function(...)'.. save_hook:format(dumper_s.outfile, ('tick() - %.4f'):format(tick())) .. 'end)');
xpcall(assert(loadstring('local cons = \'\';\n'.. r), '[cons dumper] : error in script, error when syntax?'), function(msg)
   warn('runtime error : '.. msg);
end);