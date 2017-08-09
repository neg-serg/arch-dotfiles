import os
import ycm_core

# These are the compilation flags that will be used in case there's no
# compilation database set (by default, one is not set).
# CHANGE THIS LIST OF FLAGS. YES, THIS IS THE DROID YOU HAVE BEEN LOOKING FOR.
flags = [
    '-Wall', '-Wextra', '-Werror',
    '-Wno-long-long', '-Wno-variadic-macros',
    '-fexceptions', '-DNDEBUG',
    # You 100% do NOT need -DUSE_CLANG_COMPLETER in your flags; only the YCM
    # source code needs it.
    '-DUSE_CLANG_COMPLETER',
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
    '-x', 'c++',
    # Qt-support
    '-DQT_CORE_LIB', '-DQT_GUI_LIB',
    '-DQT_NETWORK_LIB', '-DQT_QML_LIB',
    '-DQT_QUICK_LIB', '-DQT_SQL_LIB',
    '-DQT_WIDGETS_LIB', '-DQT_XML_LIB',
    '-isystem', '../BoostParts',
    # This path will only work on OS X, but extra paths that don't exist are not
    # harmful
    '-isystem', '/System/Library/Frameworks/Python.framework/Headers',
    '-isystem', '../llvm/include',
    '-isystem', '../llvm/tools/clang/include',
    '-I', '.', '-I', './include', '../include',
    '-I', './ClangCompleter',

    #GTK includes
    '-isystem', '/usr/include/gtk-3.0',
    '-isystem', '/usr/include/glib-2.0',
    '-isystem', '/usr/include/glib-2.0/glib',
    '-isystem', '/usr/lib/i386-linux-gnu/glib-2.0/include',
    '-isystem', '/usr/include/pango-1.0',
    '-isystem', '/usr/include/cairo',
    '-isystem', '/usr/include/gdk-pixbuf-2.0',
    '-isystem', '/usr/include/atk-1.0',
    '-isystem', '-I/usr/include/gio-unix-2.0',
    '-isystem', '-I/usr/include/freetype2',
    '-isystem', '-I/usr/include/pixman-1',
    '-isystem', '-I/usr/include/libpng12',

    #QT includes
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


    '-isystem', './tests/gmock/gtest',
    '-isystem', './tests/gmock/gtest/include',
    '-isystem', './tests/gmock',
    '-isystem', './tests/gmock/include',
    '-isystem', '/usr/include',
    '-isystem', '/usr/local/include',

    '-isystem', '-I', '/usr/include/c++/4.9.1',
    '-isystem', '-I', '/usr/include/c++/5.1.0',
    '-isystem', '-I', '/usr/include/c++/5.3.0',

    '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/c++/v1',
    '-isystem',
    '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include',

    '-I', 'Tests',
    '-I', 'build',
    '-I', 'build/Tests',
]


# Set this to the absolute path to the folder (NOT the file!) containing the
# compile_commands.json file to use that instead of 'flags'. See here for
# more details: http://clang.llvm.org/docs/JSONCompilationDatabase.html
#
# Most projects will NOT need to set this to anything; you can just change the
# 'flags' list of compilation flags. Notice that YCM itself uses that approach.
compilation_database_folder = ''

if os.path.exists( compilation_database_folder ):
  database = ycm_core.CompilationDatabase( compilation_database_folder )
else:
  database = None

SOURCE_EXTENSIONS = [ '.cpp', '.cxx', '.cc', '.c', '.m', '.mm' ]

def DirectoryOfThisScript():
  return os.path.dirname( os.path.abspath( __file__ ) )


def MakeRelativePathsInFlagsAbsolute( flags, working_directory ):
  if not working_directory:
    return list( flags )
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


def IsHeaderFile( filename ):
  extension = os.path.splitext( filename )[ 1 ]
  return extension in [ '.h', '.hxx', '.hpp', '.hh' ]


def GetCompilationInfoForFile( filename ):
  # The compilation_commands.json file generated by CMake does not have entries
  # for header files. So we do our best by asking the db for flags for a
  # corresponding source file, if any. If one exists, the flags for that file
  # should be good enough.
  if IsHeaderFile( filename ):
    basename = os.path.splitext( filename )[ 0 ]
    for extension in SOURCE_EXTENSIONS:
      replacement_file = basename + extension
      if os.path.exists( replacement_file ):
        compilation_info = database.GetCompilationInfoForFile(
          replacement_file )
        if compilation_info.compiler_flags_:
          return compilation_info
    return None
  return database.GetCompilationInfoForFile( filename )


def FlagsForFile( filename, **kwargs ):
  if database:
    # Bear in mind that compilation_info.compiler_flags_ does NOT return a
    # python list, but a "list-like" StringVec object
    compilation_info = GetCompilationInfoForFile( filename )
    if not compilation_info:
      return None

    final_flags = MakeRelativePathsInFlagsAbsolute(
      compilation_info.compiler_flags_,
      compilation_info.compiler_working_dir_ )

    # NOTE: This is just for YouCompleteMe; it's highly likely that your project
    # does NOT need to remove the stdlib flag. DO NOT USE THIS IN YOUR
    # ycm_extra_conf IF YOU'RE NOT 100% SURE YOU NEED IT.
    try:
      final_flags.remove( '-stdlib=libc++' )
    except ValueError:
      pass
  else:
    relative_to = DirectoryOfThisScript()
    final_flags = MakeRelativePathsInFlagsAbsolute( flags, relative_to )

  return {
    'flags': final_flags,
    'do_cache': True
  }
