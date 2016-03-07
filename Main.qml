import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 0.1

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    id: main
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "carousel0.liu-xiao-guo"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(60)
    height: units.gu(85)

    property int pathMargin: units.gu(10)
    property string imageurl

    Page {
        id: window
        title: i18n.tr("carousel0")

        PathView {
            id: view
            width: parent.width
            height: parent.height*.2
            model: Model0 {}
            delegate: Item {
                id: wrapper
                width: parent.width/4
                height: width

                Image {
                    width: parent.width*.4
                    height: width
                    source: iconSource
                }
            }
            path: Path {
                startX: 0
                startY: pathMargin
                PathLine { x: view.width; y: pathMargin }
            }
        }

        Component {
            id: mydelegate
            Item {
                id: rect
                width: view1.width/4
                height: width
                opacity: PathView.opacity
                scale: PathView.scale
                z: PathView.z
                Image {
                    id: image
                    source: iconSource
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit

                    Text {
                        color: "blue"
                        text: title
                        font.family: "Arial"
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            imageurl = image.source
                            PopupUtils.open(defaultSheet, main)
                        }
                    }
                }
            }
        }

        Component {
            id: defaultSheet
            DefaultSheet {
                id: sheet
                title: i18n.tr("This is the selected image")
                doneButton: true

                Image {
                    id: image
                    source: imageurl
                    anchors.fill: parent
                }
            }
        }

        PathView {
            id: view1
            // anchors.fill: parent
            width: parent.width
            height: parent.height*0.8
            anchors.top: view.bottom

            model: Model1 {}
            delegate: mydelegate
            path: Path {
                startX: view1.width/2; startY: 2* view1.height / 3;
                PathAttribute { name: "opacity"; value: 1 }
                PathAttribute { name: "scale"; value: 1 }
                PathAttribute { name: "z"; value: 100 }
                PathQuad { x: view1.width/2; y: view1.height / 3; controlX: view1.width+200; controlY: view1.height/2}
                PathAttribute { name: "opacity"; value: 0.3 }
                PathAttribute { name: "scale"; value: 0.5 }
                PathAttribute { name: "z"; value: 0 }
                PathQuad { x: view1.width/2; y: 2*view1.height / 3; controlX: -200; controlY: view1.height/2}
            }
        }
    }
}

