import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem


Page {
    id: track

    header: CommonHeader {
        title: i18n.tr('Track')
        flickable: listView
    }

    property var model: ListModel {}
    property var scheduleModel: ListModel {}

    anchors.fill: parent

    ListView {
        id: listView
        anchors.fill: parent
        model: track.model

        delegate: ListItem.Standard {
            progression: true
            Row {
                id: rowItem
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: units.gu(1)
                anchors.rightMargin: units.gu(1)
                spacing: units.gu(2)

                Label {
                    anchors.verticalCenter: parent.verticalCenter
                    text: title
                }
            }
            onClicked: {
                // XXX reset path and model
                //console.log("Path: " + path)
                path = [path[0], track.model.get(index).title]
                scheduleModel.clear()
                py.call("backend.find_events_by_day_track", path, function(events) {
                    //console.log("Title: " + events[0].title)
                    //console.log("Start: " + events[0].start)
                    //console.log("End: " + events[0].end)
                    //console.log("Duration: " + events[0].duration)
                    //console.log("Room: " + events[0].room)
                    //console.log("Persons: " + events[0].persons)
                    //console.log("Checked: " + events[0].lecture_checked)

                    for (var i=0; i < events.length; i++) {
                        scheduleModel.append(events[i]);
                    }
                    pageStack.push(Qt.resolvedUrl("Schedule.qml"), {"model": scheduleModel})
                })
            }
        }
    }
}
