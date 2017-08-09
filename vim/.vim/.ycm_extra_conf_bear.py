import sys
from os import listdir, getcwd, environ, devnull
from os.path import abspath, normpath, split, join, expanduser, isfile, isdir, isabs, splitdrive, splitext
import subprocess as sp
import ycm_core

cc = 'g++'
dirname = lambda x: split(x)[0]
basename = lambda x: split(x)[1]
database = None

def head_cat(p):
  try:
    with open(p, 'r') as f:
      return f.readline()
  except IOError:
    return ''

def default_cast(ttype, value, deflt=None):
  try:
    return ttype(value)
  except ValueError:
    if deflt is None:
      return ttype()
    return deflt

def is_root_dir(d):
  if isdir(d) and (basename(abspath(d)) == 'trunk' or basename(abspath(join(d, '..'))) in ('tags', 'branches')):
    return True
  for f in listdir(d):
    p = join(d, f)
    if isfile(p) and f in ('.ycm_extra_conf.py', 'Jamroot', 'Jamroot.jam', 'project-root.jam'):
      return True
    elif isdir(p):
      if f in ('.git', '.hg', '.bzr'):
        return True
      # .svn/format >= 12 means svn client 1.7 with centralized meta-data.
      elif f == '.svn' and default_cast(long, head_cat(join(p, 'format'))) >= 12:
        return True
  return False

def get_root_dir(cwd=None):
  if cwd is None: cwd = getcwd()
  while (normpath(splitdrive(cwd)[1]) not in ('/', '\\', '')):
    if is_root_dir(cwd):
      return cwd
    cwd = join(cwd, '..')
  return None

def abslistdir(p):
  absp = abspath(p)
  return (join(absp, x) for x in listdir(absp))

here = dirname(abspath(__file__))
root = get_root_dir(here)
if not root:
  root = here[:]
if isfile(join(root, 'compile_commands.json')):
  database = ycm_core.CompilationDatabase(root)
  if not database.DatabaseSuccessfullyLoaded():
    database = None

path_flags = ['-isystem', '-I', '-iquote', '--sysroot=']
def StripPathFlags(f):
  for p in path_flags:
    if f.startswith(p):
      if len(f) > len(p): return f[len(p):]
      else: return ''
  return f

def SplitPathFlags(fs):
  new_fs = []
  for f in fs:
    new_f = [f]
    for p in path_flags:
      lenp = len(p)
      if f.startswith(p) and len(f) > lenp:
        new_f = [f[:lenp], f[lenp:]]
        continue
    new_fs.extend(new_f)
  return new_fs

#def YcmIncludeFlags():
#  """Pointless: done automatically."""
#  return ['-I', join(expanduser('~'), '.vim', '.bundle', 'YouCompleteMe', 'python', 'clang_includes')]

#def SystemIncludeFlags():
#  """Pointless? Automatically get std library with automatic Ycm-clang_includes."""
#  flags = []
#  try:
#    with open(devnull, 'rb') as null:
#      env = environ.copy()
#      env['LC_ALL'] = 'C'
#      stdout = sp.check_output(
#        [cc, '-v', '-x', 'c++', '-c', '-'], env=env, universal_newlines=True
#        , stderr=sp.STDOUT, stdin=null.fileno()
#      )
#  except:
#    pass
#  else:
#    in_includes = False
#    for line in stdout.splitlines():
#      l = line.strip()
#      if l == 'End of search list.':
#        in_includes = False
#      elif in_includes and line.startswith(' '):
#        flags.extend(['-isystem', l])
#      elif l.endswith('search starts here:'):
#        in_includes = True
#  return flags

def DefaultFlags():
  paths = (absp for absp in abslistdir(root) if isdir(absp) and not basename(absp).startswith('.'))
  fs = ['-x', 'c++', '-std=c++11', '-I', root]
  for path in paths:
    includes = [p for p in abslistdir(path) if isdir(p) and basename(p) in ('include', 'inc')]
    if not includes:
      fs.extend(['-I', path])
    else:
      for inc in includes:
        fs.extend(['-I', inc])
  return fs

def MakeRelativePathsInFlagsAbsolute(fs, working_directory):
  if not working_directory:
    return list(fs)
  new_fs = []
  make_next_absolute = False
  for f in fs:
    new_f = f
    if make_next_absolute:
      make_next_absolute = False
      if not f.startswith('/'):
        new_f = join(working_directory, f)
    for p in path_flags:
      if f == p:
        make_next_absolute = True
        break
      if f.startswith(p):
        path = f[len(p):]
        new_f = p + join(working_directory, path)
        break
    if new_f:
      new_fs.append(new_f)
  return new_fs

def StripNonFlags(fs):
  """Please rewrite this: check for desired flags instead of removing unwanted ones."""
  if not fs:
    return []
  non_flag_opts = ('-c', '-o')
  non_flag_args = ('-W', '-O', '-f', '-pipe', '-g', '-m')
  new_fs = [fs[0]]
  is_arg = False
  skip_next = False
  for f in fs[1:]:
    if skip_next:
      skip_next = False
    elif not is_arg and f in non_flag_opts:
      skip_next = True
    elif not any((f.startswith(a) for a in non_flag_args)):
      if is_arg:
        is_arg = False
        new_fs.append(f)
      elif f.startswith('-') and len(f) > 1:
        is_arg = True
        new_fs.append(f)
      elif not f.startswith('-'):
        pass
  return new_fs

def AddSourceStdFlags(fs):
  if not fs:
    return []
  fs = fs[:]
  explicit_std = False
  std = None
  for f in fs:
    if f.startswith('-std='):
      explicit_std = True
      std = f
  explicit_src = False
  src = None
  is_arg = False
  is_src = False
  for f in fs:
    if is_src:
      explicit_src = True
      src = f
      break
    elif not is_arg and f == '-x':
      is_src = True
    elif f.startswith('-') and len(f) > 1:
      is_arg = True
    elif is_arg:
      is_arg = False
  cc = fs[0]
  if not src:
    if cc.endswith('++') or cc.startswith('cl'):
      src = 'c++'
    elif cc.startswith('cc') or cc.endswith('cc') or cc.startswith('clang'):
      src = 'c'
  if not src and std:
    if std.find('++') >= 0:
      src = 'c++'
    else:
      src = 'c'
  elif src and not std:
    std = '-std=' + src + '11'
  elif not src and not std:
    src = 'c++'
    std = '-std=c++11'
  if not explicit_std and std:
    fs.insert(1, std)
  if not explicit_src and src:
    fs.insert(1, src)
    fs.insert(1, '-x')
  return fs

def HeaderToSources(filename):
  """Convert a header filename into a sequence of potential source filenames."""
  head = splitext(filename)[0]
  if filename.endswith('.h'):
    return (head + e for e in ('.cc', '.cpp', '.c'))
  elif filename.endswith('.hh'):
    return (head + '.cc',)
  elif filename.endswith('.hpp'):
    return (head + '.cpp',)
  elif filename.endswith('.hxx'):
    return (head + '.cxx',)
  else:
    return (filename,)

def FlagsForFile(filename):
  if not database:
    flags = DefaultFlags()
  else:
    for f in HeaderToSources(filename):
      # GetCompilationInfoForFile returns a "list-like" StringVec object.
      compilation_info = database.GetCompilationInfoForFile(abspath(f))
      flags = AddSourceStdFlags(StripNonFlags(MakeRelativePathsInFlagsAbsolute(
        compilation_info.compiler_flags_,
        compilation_info.compiler_working_dir_ )))[1:]
      if flags:
        break
  return {'flags': SplitPathFlags(flags), 'do_cache': True}
