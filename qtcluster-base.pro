TEMPLATE = app
TARGET = qtcluster
INCLUDEPATH += .
QT += quick serialbus websockets

win32 {
    OPENSSL_DLLS = $$PWD/third_party/openssl/libeay32.dll \
                   $$PWD/third_party/openssl/ssleay32.dll

    CONFIG(debug, debug|release) {
        DESTDIR_TARGET = $$OUT_PWD/debug
    } else {
        DESTDIR_TARGET = $$OUT_PWD/release
    }

    message("DESTDIR_TARGET = $$DESTDIR_TARGET")

    for(dll, OPENSSL_DLLS) {
        QMAKE_POST_LINK += $$quote(cmd /c copy /Y $$system_path($$dll) $$system_path($$DESTDIR_TARGET)) $$escape_expand(\\n\\t)
    }
}

# Enable for static version
#CONFIG += static
#DEFINES += STATIC

CONFIG += SPORTS_CAR
CONFIG += HYBRID_CAR

#Enable compile flags based on config flags
SPORTS_CAR: DEFINES += SPORTS_CAR
HYBRID_CAR: DEFINES += HYBRID_CAR

qtHaveModule(3drender) {
QT += 3dcore 3drender 3dquick 3dquick-private
HEADERS += \
    scenehelper.h
SOURCES += \
    scenehelper.cpp
}

CONFIG += resources_big

SOURCES += \
    main.cpp \
    gauge.cpp \
    gaugenode.cpp \
    qtiviclusterdata.cpp \
    etcprovider.cpp \
    circularindicator.cpp

DEFINES += NO_NETWORK

RESOURCES += \
    qtcluster.qrc \

RESOURCES += images.qrc

SPORTS_CAR: {
    RESOURCES += sportsqml.qrc

    RESOURCES += sportscar_15k.qrc
    RESOURCES += sportsimages.qrc
}

HYBRID_CAR: {
    RESOURCES += \
        hybridqml.qrc

RESOURCES += hybridimages.qrc
}

RESOURCES += iso-icons.qrc

ISO_ICONS = \
    iso_grs_7000_4_0083 \
    iso_grs_7000_4_1434A \
    iso_grs_7000_4_0246 \
    iso_grs_7000_4_0245 \
    iso_grs_7000_4_0247 \
    iso_grs_7000_4_1555 \
    iso_grs_7000_4_1702 \
    iso_grs_7000_4_0249 \
    iso_grs_7000_4_0238 \
    iso_grs_7000_4_0456


OTHER_FILES += \
    qml/* \
    qml/dash_sports/* \
    qml/dash_hybrid/* \
    qml/dash_hybrid/gauges/* \
    qml/dash_safety/* \

#win32 | win64: {
#    deploy.path = $$OUT_PWD
#} else {
    deploy.path = /data/user/qt
#}

#message($$deploy.path)

#qml_data.files += qml/*
#qml_data.path = $$deploy.path/$$TARGET/qml
#font_data.files += fonts/*
#font_data.path = $$deploy.path/$$TARGET/fonts
#image_data.files += images/*
#image_data.path = $$deploy.path/$$TARGET/images
target.path = $$deploy.path/$$TARGET
INSTALLS += \
    target \
#    video_data \
#    qml_data \
#    font_data \
#    image_data

HEADERS += \
    gauge.h \
    gaugenode.h \
    qtiviclusterdata.h \
    etcprovider.h \
    circularindicator.h

macos: QMAKE_INFO_PLIST = Info-macos.plist
ios|tvos: QMAKE_INFO_PLIST = Info-ios.plist

DISTFILES +=

