QT += quick

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    src/main.cpp \
    src/notificationhandler.cpp

HEADERS += \
    src/notificationhandler.h

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


ios {

    QMAKE_TARGET_BUNDLE_PREFIX = com.softmax
    QMAKE_BUNDLE = vhhchat


#    MY_DEVELOPEMENT_TEAM.value = "XAHJ4A6X4G"
#    MY_DEVELOPEMENT_TEAM.name = "SOFTMAX COMPANY LIMITED"
#    QMAKE_MAC_XCODE_SETTINGS += MY_DEVELOPEMENT_TEAM

    MY_ENTITLEMENTS.name = CODE_SIGN_ENTITLEMENTS
    MY_ENTITLEMENTS.value = $$PWD/ios/pushnotifications.entitlements
    QMAKE_MAC_XCODE_SETTINGS += MY_ENTITLEMENTS

    QMAKE_INFO_PLIST = $$PWD/ios/Info.plist

    PLUGINS.path = PlugIns
    PLUGINS.files = $$PWD/PlugIns/notifications.appex
    QMAKE_BUNDLE_DATA += PLUGINS

    CONFIG -= bitcode

    LIBS += -framework UIKit

    OBJECTIVE_SOURCES += \
        ios/QPushApplicationDelegate.mm

    DISTFILES += \
        ios/pushnotifications.entitlements \
        ios/Info.plist
}
