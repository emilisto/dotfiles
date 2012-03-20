#!/usr/bin/python
# -*- coding: utf-8 -*-

import argparse
import json
import sys
import re


def parse_args():
    parser = argparse.ArgumentParser(
        description='Formats (tidies) a JSON text stream.')

    parser.add_argument(
        '-i', '--indent',
        metavar='level',
        type=int,
        default=4,
        dest='indent',
        help='level of indentation (default 4)')

    parser.add_argument(
        '-c', '--item-separator',
        metavar='separator',
        default=',',
        dest='item_separator',
        help='dictionary seperator (default \',\')')

    parser.add_argument(
        '-d', '--dict-separator',
        metavar='separator',
        default=':',
        dest='dict_separator',
        help='dictionary seperator (default \':\')')

    parser.add_argument(
        '-s', '--sort-keys',
        action='store_true',
        default=False,
        dest='sort_keys',
        help='sorts output by key')

    parser.add_argument(
        '-w', '--strip-whitespace',
        action='store_true',
        default=False,
        dest='strip_whitespace',
        help='remove whitespace from output (compact JSON)')

    return parser.parse_args()


def parse_json(input):
    text = None

    try:
        obj = json.loads(input)

        text = json.dumps(
            obj,
            indent=args.indent,
            sort_keys=args.sort_keys,
            separators=(args.item_separator, args.dict_separator))

    except ValueError:
        print 'Could not parse input as JSON.'

    return text


def strip_whitespace(text):
    pattern = re.compile(r'\s+')
    return re.sub(pattern, '', text)


def filter(args):
    input = sys.stdin.read()

    text = parse_json(input)

    if text is not None:

        if args.strip_whitespace:
            text = strip_whitespace(text)

        sys.stdout.write(text)

args = parse_args()
filter(args)
