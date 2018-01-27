#!/usr/bin/python3

import mimetypes
import sys
import os
import re

HOME_DIR = os.environ["HOME"]

POSSIBLE_PATHS = {
    'audio': os.path.join(HOME_DIR, "Music"),
    'video': os.path.join(HOME_DIR, "Videos"),
    'other': os.path.join(HOME_DIR, "Downloads"),
    'image': os.path.join(HOME_DIR, "Pictures")
}


def files_line(data: str) -> int:
    data = data.splitlines()
    index = 0
    for line in data:
        if "FILES" in line:
            index = data.index(line)
    index += 2
    return data[index:]


def get_prevalent_filetype(data: list) -> str:
    filetypes = {
        'audio': 0,
        'video': 0,
        'application': 0,
        'image': 0,
        'other': 0
    }
    for file_line in data:
        size_index = file_line.rfind('(') - 1
        mimetype = mimetypes.guess_type(file_line[:size_index])[0]
        # Mimetype metaclass, i.e. video, audio, etc.
        mt_metaclass = mimetype[:mimetype.rfind('/')]
        try:
            filetypes[mt_metaclass] += 1
        except KeyError:
            continue
    return prevalent(filetypes)


def prevalent(filetypes: dict) -> str:
    values = list(filetypes.values())
    prevalent_index = values.index(max(values))
    prevalent_filetype = list(filetypes.keys())[prevalent_index]
    if prevalent_filetype not in POSSIBLE_PATHS.values():
        audio_count = filetypes.get('audio', 0)
        video_count = filetypes.get('video', 0)
        if audio_count == video_count == 0:
            return 'other'
        elif audio_count > video_count:
            return 'audio'
        elif video_count > audio_count:
            return 'video'
        else:
            # Huynya kakaya-to
            return 'other'
    return prevalent_filetype


def main():
    if sys.argv[1] == "":
        return os.path.join(HOME_DIR, "Downloads")
    data = files_line(sys.argv[1])
    torrent_ft = get_prevalent_filetype(data)
    print(POSSIBLE_PATHS.get(torrent_ft))

if __name__ == '__main__':
    main()
