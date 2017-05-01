#! /usr/bin/env python3

import json
import argparse
import os
import re


def load_compile_commands(build_dir):
    compile_commands_path = os.path.join(build_dir, 'compile_commands.json')
    try:
        with open(compile_commands_path, 'r') as f:
            return json.load(f)
    except EnvironmentError as error:
        print("error when trying to read {}: {}".format(
            compile_commands_path, error.message))
        exit(1)
    except Exception as error:
        print("error when parsing compile_commands.json: {}".format(
            error.message))
        exit(1)


def load_cmakecache(build_dir):
    cmakecache_path = os.path.join(build_dir, 'CMakeCache.txt')
    try:
        with open(cmakecache_path, 'r') as f:
            return f.readlines()
    except EnvironmentError as error:
        print("error when trying to read {}: {}".format(
            cmakecache_path, error.message))
        exit(1)


def replace_include_flags(compile_command):
    compile_command = re.sub(r'-I\s*/usr', r'-I=/usr', compile_command)
    compile_command = re.sub(r'-isystem\s*/usr', r'-isystem=/usr',
                             compile_command)
    return compile_command


def fix_compile_commands(compile_commands_content, sysroot):
    for trans_unit in compile_commands_content:
        trans_unit['command'] = "{} --sysroot {}".format(
            replace_include_flags(trans_unit['command']), sysroot)


def find_source_dir(cmakecache_content):
    magic_constant = "CMAKE_HOME_DIRECTORY:INTERNAL"
    try:
        possible_source_dirs = [
            s.split('=', 1)[1] for s in cmakecache_content
            if s.startswith(magic_constant)
        ]
        if len(possible_source_dirs) == 0:
            raise ValueError('no line in the cmakecache starts with {}'.format(
                magic_constant))
        if len(possible_source_dirs) > 1:
            raise ValueError('too many lines in the cmakecache start with {}'.
                             format(magic_constant))
        source_dir = possible_source_dirs[0].strip()
        with open(os.path.join(source_dir, 'CMakeLists.txt')) as f:
            f.readlines()
        return source_dir
    except Exception as error:
        print('%: %'.format('error when attempting to find the source dir:',
                            error.message))
        exit(1)


def main():
    parser = argparse.ArgumentParser(description='Process some integers.')
    parser.add_argument('path', help='the path of the build dir')
    parser.add_argument(
        'sysroot', help='the sysroot path to append to the compile flags')
    args = parser.parse_args()
    build_dir = args.path
    sysroot = args.sysroot

    compile_commands_content = load_compile_commands(build_dir)
    fix_compile_commands(compile_commands_content, sysroot)
    cmakecache_content = load_cmakecache(build_dir)
    source_dir = find_source_dir(cmakecache_content)
    destination = os.path.join(source_dir, 'compile_commands.json')
    try:
        with open(destination, 'w') as f:
            json.dump(compile_commands_content, f)
    except Exception as error:
        print('error when saving to {}: {}'.format(destination), error.message)
        exit(1)
    exit(0)


if __name__ == '__main__':
    main()
