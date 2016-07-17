import QtQuick 2.5

Item {
    width: parent.width
    height: parent.height
    visible: false

    property QtObject target

    function show(title, targetObject)
    {
        titleText.text = title
        target = targetObject
        visible = true
    }

    function hide()
    {
        visible = false
    }

    Rectangle {
        opacity: 0.7
        anchors.fill: parent
        color: "black"
        MouseArea {
            onClicked: {
                //Catch signal
            }
        }
    }

    Rectangle {
        radius: appStyle.borderRadius
        anchors.centerIn: parent
        width: 0.8 * parent.width
        height: childrenRect.height + radius * 2
        color: "#333"

        Column {
            y: appStyle.borderRadius
            width: parent.width
            height: childrenRect.height
            spacing: appStyle.sidesMargin

            Item {
                width: parent.width
                height: titleText.height + 2 * appStyle.sidesMargin

                BaseText {
                    id: titleText
                    x: appStyle.sidesMargin
                    y: appStyle.sidesMargin
                    width: parent.width - 2 * appStyle.sidesMargin

                    wrapMode: Text.Wrap
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Row {
                height: childrenRect.height
                width: parent.width

                ActionDialogItem {
                    text: "Cancel"
                    width: parent.width / 2
                    showSeparator: false
                    onClicked: {
                        confirmDialog.hide()
                        confirmDialog.target.onRefused()
                    }
                }
                ActionDialogItem {
                    text: "Ok"
                    width: parent.width / 2
                    showSeparator: false
                    onClicked: {
                        confirmDialog.hide()
                        confirmDialog.target.onAccepted()
                    }
                }
            }
        }
    }
}