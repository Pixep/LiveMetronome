import QtQuick 2.5

import "../controls"

BaseDialog {
    id: dialog
    width: parent.width
    height: parent.height

    property QtObject target
    property bool showCancel: true

    function show(title, targetObject)
    {
        if (targetObject === undefined)
            targetObject = null

        titleText.text = title
        target = targetObject
        visible = true
        showCancel = true

        __show()
    }

    function showMessage(title, targetObject)
    {
        if (targetObject === undefined)
            targetObject = null

        titleText.text = title
        target = targetObject
        visible = true
        showCancel = false

        __show()
    }

    function close(accepted)
    {
        if (!active)
            return

        __close()

        if (target === null)
            return

        if (accepted)
            dialog.target.onAccepted()
        else
            dialog.target.onRefused()
    }

    Rectangle {
        id: background
        radius: appStyle.borderRadius
        anchors.centerIn: parent
        width: 0.8 * parent.width
        height: childrenRect.height + radius * 2
        color: "#333"

        Column {
            id: contentColumn
            y: appStyle.borderRadius
            width: parent.width
            height: childrenRect.height
            spacing: appStyle.margin

            Item {
                width: parent.width
                height: titleText.height + 2 * appStyle.margin

                BaseText {
                    id: titleText
                    x: appStyle.margin
                    y: appStyle.margin
                    width: parent.width - 2 * appStyle.margin

                    wrapMode: Text.Wrap
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Rectangle {
                id: separator
                color: appStyle.backgroundColor2
                width: parent.width
                height: 1

                Rectangle {
                    color: appStyle.backgroundColor2
                    width: 1
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: background.height - separator.y - contentColumn.y
                    visible: dialog.showCancel
                }
            }

            Row {
                height: childrenRect.height
                width: parent.width

                ActionDialogItem {
                    iconSource: "qrc:/qml/images/icon_clear.png"
                    width: parent.width / 2
                    showSeparator: false
                    visible: dialog.showCancel
                    onClicked: {
                        dialog.close(false)
                    }
                }
                ActionDialogItem {
                    iconSource: "qrc:/qml/images/icon_check.png"
                    width: dialog.showCancel ? parent.width / 2 : parent.width
                    showSeparator: false
                    onClicked: {
                        dialog.close(true)
                    }
                }
            }
        }
    }
}
