#/usr/bin/env python3
import os
import sys
import subprocess

debugEmakefile = '''
{ "src/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"},debug_info]}.
{"src/ai_lib/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"},debug_info]}.
{ "src/data/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"},debug_info]}.
{ "src/frame/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"},debug_info]}.
{ "src/log/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"},debug_info]}.
{ "src/map_lib/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"},debug_info]}.
{ "src/misc_lib/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"},debug_info]}.
{ "src/mod/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"},debug_info]}.
{ "src/mysql_lib/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"},debug_info]}.
{ "src/pp/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"},debug_info]}.
{ "src/protocol/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"},debug_info]}.
{ "src/robot/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"},debug_info]}.
{ "src/share_lib/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"},debug_info]}.
{ "src/test/*" , [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"},debug_info]}.
{ "src/timer/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"},debug_info]}.
'''

releaseEmakefile = '''
{ "src/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"}]}.
{"src/ai_lib/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"}]}.
{ "src/data/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"}]}.
{ "src/frame/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"}]}.
{ "src/log/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"}]}.
{ "src/map_lib/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"}]}.
{ "src/misc_lib/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"}]}.
{ "src/mod/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"}]}.
{ "src/mysql_lib/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"}]}.
{ "src/pp/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"}]}.
{ "src/protocol/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"}]}.
{ "src/robot/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"}]}.
{ "src/share_lib/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"}]}.
{ "src/test/*" , [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"}]}.
{ "src/timer/*", [verbose, report, {i, "include"},{i, "include/common_include"}, {outdir, "ebin"}]}.
'''

gameProjectPath = "../"
os.chdir(gameProjectPath)

compilingOptions = ''
if len(sys.argv) == 2:
    compilingOptions = sys.argv[1]

if __name__ == '__main__':
    emakeFile = ''
    if compilingOptions == 'debug':
        emakeFile = debugEmakefile
    elif compilingOptions == 'release':
        emakeFile = releaseEmakefile
    else :
        if os.name == 'nt':
            emakeFile = debugEmakefile
        else:
            emakeFile = releaseEmakefile
    with open('Emakefile', mode='w', closefd=True ) as fd:
        fd.write( emakeFile )
    command = 'erl -make'
    subprocess.Popen(command)
    print( 'all files compiled')

