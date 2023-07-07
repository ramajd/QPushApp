import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15


ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Qt Push notification Test")


    ColumnLayout {
        anchors.fill: parent


        GroupBox {
            title: qsTr("Push Notification")
            Layout.margins: 10
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop

            ColumnLayout {
                anchors.fill: parent

                Label { text: qsTr("Device Token (Hex)") }
                TextArea {
                    id: txtTokenHex
                    Layout.fillWidth: true
                    wrapMode: Text.Wrap
                    readOnly: true
                    selectByMouse: true
                    selectByKeyboard: true
                    placeholderText: qsTr("DEVICE TOKEN (HEX)")
                }

                Label { text: qsTr("Device Token (Base64)") }
                TextArea {
                    id: txtTokenBase64
                    Layout.fillWidth: true
                    wrapMode: Text.Wrap
                    readOnly: true
                    selectByMouse: true
                    selectByKeyboard: true
                    text: notification.token
                    placeholderText: qsTr("DEVICE TOKEN (Base64)")
                }

                Connections {
                    target: notification
                    onTokenChanged: {
                        console.log('QML token changed')
                        txtTokenHex.text = notification.tokenHex()
                        txtTokenBase64.text = notification.tokenBase64()
                    }
                }
            }
        }
    }
}
