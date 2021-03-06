#!/bin/sh
# last updated : 2017/05/01 12:26:55 JST
#
# 2chproxy.pl を起動してからJDを起動する。
#

# 2chproxy.plの場所をフルpathで書く。
PROXY="$HOME/bin/2chproxy.pl"
# JDの場所
JD="/usr/bin/jd"
# 設定ファイルの場所。使わなければ放置で。
CONFIG="$HOME/.2chproxy.yml"

if [  -f ${PROXY} ]; then
	if [ ! -x ${PROXY} ]; then
		echo "${PROXY} に実行属性が付与されていません。chmod +x して付与してください。";
		exit 1;
	fi
else
	echo "${PROXY} が見つかりません。\n pathかファイル名が正しいか確認してください。";
	exit 1;
fi

pgrep 2chproxy.pl
if [ $? -ne 0 ]; then
	if [ -e ${CONFIG} ]; then
		${PROXY} --daemon --config ${CONFIG};
	else
		${PROXY} --daemon;
	fi
	$JD;
	${PROXY} --kill;
else
	$JD;
	${PROXY} --kill;
fi

