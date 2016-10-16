--
-- Premake script (http://premake.github.io)
--

function remove_system_dependent_files()
	local exclude_files = 
	{
		windows = {'src/**_mac.*', 'src/**_posix.*'},
		linux = {'src/**_mac.*', 'src/**_win.*'},
		osx = {'src/**_mac.*', 'src/**_win.*'},
	}
	removefiles(exclude_files[os.get()])
end	

workspace 'CppServerBootstrap'
    configurations  {'Debug', 'Release'}
    language        'C++'
    targetdir 		'bin/%{cfg.buildcfg}'
	architecture 	'x64'

    filter 'configurations:Debug'
        defines     { 'DEBUG' }
		symbols		'On'

    filter 'configurations:Release'
        defines     { 'NDEBUG' }
        symbols		'On'
        optimize    'On'

    configuration 'vs*'
        defines
        {
			'_WIN32_WINNT=0x0601',
            'WIN32_LEAN_AND_MEAN',
			'_CRT_SECURE_NO_WARNINGS',
			'_SCL_SECURE_NO_WARNINGS',
            '_ALLOW_KEYWORD_MACROS',
            'NOMINMAX',
			'NOGDI',
        }
        includedirs 
        {
            'third_party/googletest/include',
			'third_party/googlemock/include',
        }
        libdirs
        {
            'bin',
        }
		
		filter 'system:windows'
			includedirs
			{
				'third_party/glog/src/windows'
			}
			
		filter 'system:linux'
			includedirs
			{
				'third_party/glog/src'
			}			

    project 'Base'
        location    'build'
        kind        'StaticLib'
        includedirs
        {
            'src',
        }
        files
        {
            'src/base/**.h',
            'src/base/**.cc',
        }
		removefiles
		{
			'src/base/**_unittest.cc',
			'src/base/third_party/dmg_fp/dtoa.cc',
		}
		remove_system_dependent_files()
		
		filter 'system:windows'
			removefiles
			{
				'src/base/strings/string16.cc',
			}

    project 'UnitTest'
        location    'build'
        kind        'ConsoleApp'
		defines
		{
			'UNIT_TEST',
		}
        includedirs
        {
            'src',
			'src/test',
            'third_party/googletest',
        }
        files
        {
            'third_party/googletest/src/gtest-all.cc',
            'src/test/*.h',
			'src/test/*.cc',
			'src/**_unittest.cc',
        }        
        links 
        {
            'Base',
        }
    