#!/bin/bash

# __author__ = "Alberto Pettarin"
# __copyright__ = """
#     Copyright 2012-2013, Alberto Pettarin (www.albertopettarin.it)
#     Copyright 2013-2015, ReadBeyond Srl   (www.readbeyond.it)
#     Copyright 2015,      Alberto Pettarin (www.albertopettarin.it)
#     """
# __license__ = "GNU AGPL 3"
# __version__ = "1.3.2"
# __email__ = "aeneas@readbeyond.it"
# __status__ = "Production"

DEB="deb-multimedia-keyring_2015.6.1_all.deb"

echo "[INFO] A.2 Downloading and installing deb-multimedia keyring..."
wget -t 5 "http://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/$DEB"
if ! [ -e "$DEB" ]
then
    echo "[ERRO] Cannot download the deb-multimedia keyring."
    echo "[ERRO] This might be due to a temporary network or server problem."
    echo "[ERRO] Please retry installing this Vagrant box later."
    echo "[ERRO] If the problem persists, please send an email to aeneas@readbeyond.it"
    exit 1
fi
dpkg -i "$DEB"
rm "$DEB"
echo "[INFO] A.2 Downloading and installing deb-multimedia keyring... done"

echo "[INFO] A.3 Adding deb-multimedia to apt sources..."
sh -c 'echo "" >> /etc/apt/sources.list'
sh -c 'echo "deb http://www.deb-multimedia.org jessie main" >> /etc/apt/sources.list'
sh -c 'echo "" >> /etc/apt/sources.list'
echo "[INFO] A.3 Adding deb-multimedia to apt sources... done"

echo "[INFO] A.4 Updating apt..."
apt-get update
echo "[INFO] A.4 Updating apt... done"

echo "[INFO] B.1 Installing ffmpeg (from deb-multimedia)..."
apt-get install -y ffmpeg
echo "[INFO] B.1 Installing ffmpeg (from deb-multimedia)... done"

echo "[INFO] B.2 Installing espeak..."
apt-get install -y espeak espeak-data libespeak1 libespeak-dev
echo "[INFO] B.2 Installing espeak... done"

echo "[INFO] B.3 Installing common libs using apt-get..."
apt-get install -y build-essential
apt-get install -y flac libasound2-dev libsndfile1-dev vorbis-tools
apt-get install -y python-beautifulsoup python-dev python-lxml python-numpy
echo "[INFO] B.3 Installing common libs using apt-get... done"

echo "[INFO] C.1 Installing Python modules using pip..."
# these Debian packages provide pip and the C headers needed to compile lxml
apt-get install -y python-pip libxml2-dev libxslt-dev
pip install BeautifulSoup lxml numpy pafy
echo "[INFO] C.1 Installing Python modules using pip... done"

echo "[INFO] Congratulations, now you can use aeneas!"
