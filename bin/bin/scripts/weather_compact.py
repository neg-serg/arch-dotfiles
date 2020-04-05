#!/usr/bin/env python3
# Displaying current weather and forecast in terminal using OpenWeatherMap data
# Copyright (c) 2015 Yu-Jie Lin
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.


import argparse
import json
import sys
from datetime import datetime
from http.client import HTTPConnection
from os.path import exists
from urllib.parse import quote

__program__ = 'ww.py'
__description__ = (
  'Displaying current weather and forecast in terminal '
  'using OpenWeatherMap data'
)
__copyright__ = 'Copyright (c) 2015 Yu Jie Lin'
__license__ = 'MIT License'
__website__ = 'https://gist.github.com/livibetter/efc9405f42abc8410131'

__author__ = 'Yu-Jie Lin'
__author_email__ = 'livibetter@gmail.com'


# http://openweathermap.org/api
conn = None
API_KEY = '2027edf4a4074c72f69d78f6c432646c'
API_HOST = 'api.openweathermap.org'
API_CURRENT = '/data/2.5/weather?q=%s'
API_FORECAST = '/data/2.5/forecast?q=%s'
API_DAILY = '/data/2.5/forecast/daily?q=%s&cnt=8'


SPARKS = '▁▂▃▄▅▆▇█'
SPARKS = SPARKS + SPARKS[-1]
COLORS_TEMP = (16, 58, 100, 142, 184, 191, 227, 226, 226)
COLORS_RAIN = (16, 23, 30, 37, 43, 50, 51, 87, 87)
WIDTH = 10


def load_json(url, filename=None):

  global conn

  if filename and exists(filename):
    with open(filename) as f:
      return json.load(f)

  if not conn:
    conn = HTTPConnection(API_HOST)
  conn.request('GET', '%s&APPID=%s' % (url, API_KEY))
  resp = conn.getresponse()
  if resp.status != 200:
    print('ERROR: %d - %s' % (resp.status, resp.reason), file=sys.stderr)
  data = resp.read().decode('utf-8')

  if filename:
    with open(filename, 'w') as f:
      f.write(data)

  return json.loads(data)


def convert_temp(temp_K, unit='C'):

  if unit == 'C':
    return temp_K - 273.15
  elif unit == 'F':
    return temp_K * 9 / 5 - 459.67
  else:
    return temp_K


def color_cond(cond):

  escape = ''
  # http://openweathermap.org/weather-conditions
  if 200 <= cond < 300:  # Thunderstorm
    escape = '\033[48;5;226m'
  elif 300 <= cond < 400:  # Drizzle
    escape = '\033[38;5;21m'
  elif 500 <= cond < 600:  # Rain
    escape = '\033[48;5;21m'
  elif 600 <= cond < 700:  # Snow
    escape = '\033[38;5;16m\033[48;5;231m'
  elif 900 <= cond <= 906:  # Extreme
    escape = '\033[38;5;231m\033[48;5;196m'

  return escape


def color_hour(hour):

  escape = '\033[48;5;16m'
  if 6 <= hour < 18:
    h = hour - 6
    if h >= 6:
      h = 12 - h - 1
    escape = '\033[48;5;%dm' % (16 + h)

  return escape


def print_dt_sparks(dts, values, width=WIDTH, colors=None, escape=''):

  value_min = min(values)
  value_max = max(values)
  value_diff = value_max - value_min
  if value_diff == 0:
    value_diff = 1
  value_step = value_diff / (len(SPARKS) - 1)

  print(' ' * ((width - 1) // 2), end='')
  for i in range(len(values) - 1):
    value = values[i]
    value_next = values[i + 1]
    diff = value_next - value
    value_sparks = [value + j * diff / width for j in range(width)]
    for j, t in enumerate(value_sparks):
      h = dts[i].hour
      h = h + (3 * j // len(value_sparks))
      idx = int((t - value_min) / value_step)
      if colors:
        print('\033[38;5;%dm' % colors[idx], end='')
      print('%s%s%s' % (color_hour(h), SPARKS[idx], '\033[0m'), end='')
  idx = int((values[-1] - value_min) / value_step)
  if colors:
    print('\033[38;5;%dm' % colors[idx], end='')
  print('%s%s%s' % (color_hour(h), SPARKS[idx], '\033[0m'))

  print_values(values, width=width, escape=escape)


def print_strings(strings, width=WIDTH):

  for string in strings:
    print('{:^{width}s}'.format(string, width=width), end='')
  print()


def print_values(values, fmt='{:5.1f}', width=WIDTH, escape=''):

  for value in values:
    s = fmt.format(value)
    len_s = len(s)
    if escape:
      s = escape + s + '\033[0m'
    print_string(s, len_s, width)
  print()


def print_string(s, s_len, width):

  pad_len = width - s_len
  print('%s%s%s' % (
    ' ' * (pad_len // 2),
    s,
    ' ' * (pad_len - pad_len // 2),
  ), end='')


def print_dates(dts, width=WIDTH):

  today = datetime.today()

  for dt in dts:
    escape = ''
    if dt.weekday() == 5:
      escape = '\033[38;5;148m'
    elif dt.weekday() == 6:
      escape = '\033[38;5;204m'
    if today.month == dt.month and today.day == dt.day:
      escape += '\033[1m'

    s = dt.strftime('%A')
    print_string(escape + s + '\033[0m', len(s), width)
  print()

  for dt in dts:
    escape = ''
    if today.month == dt.month and today.day == dt.day:
      escape += '\033[1m'
    elif today.month * 100 + today.day < dt.month * 100 + dt.day:
      escape += '\033[4m'

    s = dt.strftime('%m-%d')
    print_string(escape + s + '\033[0m', len(s), width)
  print()


def print_conditions(conds, width=WIDTH):

  for cond in conds:
    s = cond['main']
    print_string(color_cond(cond['id']) + s + '\033[0m', len(s), width)
  print()


def main():

  parser = argparse.ArgumentParser(description=__description__)
  parser.add_argument('-j', '--json', action='store_true',
                      help='store and use JSON files for caching')
  parser.add_argument('query', type=str, nargs='+',
                      help='query string for location')
  args = parser.parse_args()

  q = quote(' '.join(args.query))

  current = load_json(API_CURRENT % q, args.json and 'current.json')

  loc = '%s, %s' % (current['name'], current['sys']['country'])
  print('{:s}{:>{width}s}'.format(
    loc,
    datetime.fromtimestamp(current['dt']).strftime('%A %X, %B %d, %Y'),
    width=80 - len(loc)
  ))
  fmt = ' / '.join((
    '%s',
    '\033[38;5;156m%.1f C\033[0m',
    '\033[38;5;33m%.1f mm\033[0m',
    '\033[38;5;110m%d%%\033[0m',
    '\033[38;5;248m%d m/s\033[0m',
  ))
  print(fmt % (
    '%s%s%s' % (
      color_cond(current['weather'][0]['id']),
      current['weather'][0]['description'].title(),
      '\033[0m',
    ),
    convert_temp(current['main']['temp'], 'C'),
    current.get('rain', {'1h': 0})['1h'],
    current['main']['humidity'],
    current['wind']['speed'],
  ))
  print()

  forecast = load_json(API_FORECAST % q, args.json and 'forecast.json')
  items = forecast['list'][:8]

  dts = [datetime.fromtimestamp(item['dt']) for item in items]
  print_strings([dt.strftime('%H:%M') for dt in dts])
  temps = [convert_temp(item['main']['temp'], 'C') for item in items]
  print_dt_sparks(dts, temps, colors=COLORS_TEMP, escape='\033[38;5;156m')
  rains = [item.get('precipitation', {'3h': 0})['3h'] for item in items]
  print_dt_sparks(dts, rains, colors=COLORS_RAIN, escape='\033[38;5;33m')
  print()

  forecast = load_json(API_DAILY % q, args.json and 'daily.json')
  items = forecast['list']

  dts = [datetime.fromtimestamp(item['dt']) for item in items]
  print_dates(dts)
  print_conditions([item['weather'][0] for item in items])

  temps = [convert_temp(item['temp']['max'], 'C') for item in items]
  print_values(temps, escape='\033[38;5;228m')
  temps = [convert_temp(item['temp']['min'], 'C') for item in items]
  print_values(temps, escape='\033[38;5;158m')
  print_values([item.get('rain', 0) for item in items], escape='\033[38;5;33m')
  print_values([item['humidity'] for item in items], escape='\033[38;5;110m')

  if conn:
    conn.close()


if __name__ == '__main__':
    main()
