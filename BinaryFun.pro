# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = BinaryFun

CONFIG += sailfishapp

SOURCES += src/BinaryFun.cpp

DISTFILES += qml/BinaryFun.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/BinaryFun.changes.in \
    rpm/BinaryFun.changes.run.in \
    rpm/BinaryFun.spec \
    rpm/BinaryFun.yaml \
    translations/*.ts \
    BinaryFun.desktop \
    qml/pages/LeaderBoard.qml

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/BinaryFun-de.ts
