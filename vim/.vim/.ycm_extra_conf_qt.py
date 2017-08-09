import os
import ycm_core
from clang_helpers import PrepareClangFlags

# Set this to the absolute path to the folder (NOT the file!) containing the
# compile_commands.json file to use that instead of 'flags'. See here for
# more details: http://clang.llvm.org/docs/JSONCompilationDatabase.html
# Most projects will NOT need to set this to anything; you can just change the
# 'flags' list of compilation flags. Notice that YCM itself uses that approach.
compilation_database_folder = ''

# These are the compilation flags that will be used in case there's no
# compilation database set.
flags = [
# THIS IS IMPORTANT! Without a "-std=<something>" flag, clang won't know which
# language to use when compiling headers. So it will guess. Badly. So C++
# headers will be compiled as C headers. You don't want that so ALWAYS specify
# a "-std=<something>".
# For a C project, you would set this to something like 'c99' instead of
# 'c++11'.
'-std=c++11',
# ...and the same thing goes for the magic -x option which specifies the
# language that the files to be compiled are written in. This is mostly
# relevant for c++ headers.
# For a C project, you would set this to 'c' instead of 'c++'.
'-x',
'c++',
'-DQT_CORE_LIB',
'-DQT_GUI_LIB',
'-DQT_NETWORK_LIB',
'-DQT_QML_LIB',
'-DQT_QUICK_LIB',
'-DQT_SQL_LIB',
'-DQT_WIDGETS_LIB',
'-DQT_XML_LIB',

'-isystem',
'/usr/include',
'-isystem',
'/usr/local/include',
'-isystem',
'/usr/include/c++/4.8.2',
'-isystem',
'/usr/include/c++/4.9.0',
'-isystem',
'/usr/include/c++/4.9.1/',
'-isystem',
'/usr/include/c++/4.9.2/',
'-Wundef',
'-Wstrict-prototypes',
'-Wno-trigraphs',
'-fno-strict-aliasing',
'-fno-common',
'-Werror-implicit-function-declaration',
'-Wno-format-security',
'-nostdinc',

'-I', '/usr/lib/qt/mkspecs/linux-clang',
'-I', '/usr/include/qt',
'-I', '/usr/include/qt/QtConcurrent',
'-I', '/usr/include/qt/QtCore',
'-I', '/usr/include/qt/QtDBus',
'-I', '/usr/include/qt/QtGui',
'-I', '/usr/include/qt/QtHelp',
'-I', '/usr/include/qt/QtMultimedia',
'-I', '/usr/include/qt/QtMultimediaWidgets',
'-I', '/usr/include/qt/QtNetwork',
'-I', '/usr/include/qt/QtOpenGL',
'-I', '/usr/include/qt/QtPlatformSupport',
'-I', '/usr/include/qt/QtPositioning',
'-I', '/usr/include/qt/QtScript',
'-I', '/usr/include/qt/QtScriptTools',
'-I', '/usr/include/qt/QtSql',
'-I', '/usr/include/qt/QtSvg',
'-I', '/usr/include/qt/QtTest',
'-I', '/usr/include/qt/QtUiTools',
'-I', '/usr/include/qt/QtV8',
'-I', '/usr/include/qt/QtWebKit',
'-I', '/usr/include/qt/QtWebKitWidgets',
'-I', '/usr/include/qt/QtWidgets',
'-I', '/usr/include/qt/QtXml',
'-I', '/usr/include/qt/QtXmlPatterns',
'-I', '/usr/include/boost/spirit'


'-I', '.',
'-I', './include',
'-I', 'Tests',
'-I', 'build',
'-I', 'build/Tests'
]

if compilation_database_folder:
  database = ycm_core.CompilationDatabase( compilation_database_folder )
else:
  database = None


def DirectoryOfThisScript():
  return os.path.dirname( os.path.abspath( __file__ ) )


def MakeRelativePathsInFlagsAbsolute( flags, working_directory ):
  if not working_directory:
    return flags
  new_flags = []
  make_next_absolute = False
  path_flags = [ '-isystem', '-I', '-iquote', '--sysroot=' ]
  for flag in flags:
    new_flag = flag

    if make_next_absolute:
      make_next_absolute = False
      if not flag.startswith( '/' ):
        new_flag = os.path.join( working_directory, flag )

    for path_flag in path_flags:
      if flag == path_flag:
        make_next_absolute = True
        break

      if flag.startswith( path_flag ):
        path = flag[ len( path_flag ): ]
        new_flag = path_flag + os.path.join( working_directory, path )
        break

    if new_flag:
      new_flags.append( new_flag )
  return new_flags


def FlagsForFile( filename ):
  if database:
    # Bear in mind that compilation_info.compiler_flags_ does NOT return a
    # python list, but a "list-like" StringVec object
    compilation_info = database.GetCompilationInfoForFile( filename )
    final_flags = PrepareClangFlags(
        MakeRelativePathsInFlagsAbsolute(
            compilation_info.compiler_flags_,
            compilation_info.compiler_working_dir_ ),
        filename )
  else:
    relative_to = DirectoryOfThisScript()
    final_flags = MakeRelativePathsInFlagsAbsolute( flags, relative_to )

  return {
    'flags': final_flags,
    'do_cache': True
  }
