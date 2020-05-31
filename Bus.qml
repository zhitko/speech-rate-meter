import QtQuick 2.14
import QtQuick.Controls 2.14

Item {
    id: bus

    property var stackView

    property string metricsPage: "Pages/Metrics/MetricsPage.qml";
    signal openedMetricsPage(string path)
    function openMetricsPage(path)
    {
        console.log("Try to open Metrics Page " + path);
        stackView.pop()
        stackView.push(metricsPage, {name: "Metrics", path: path, bus: bus})
        openedMetricsPage(path)
    }

    property string welcomePage: "Pages/Welcome/WelcomePage.qml";
    signal openedWelcomePage()
    function openWelcomePage()
    {
        stackView.clear();
        stackView.push(welcomePage, {bus: bus})
        openedWelcomePage()
    }

    property string settingsPage: "Pages/Settings/SettingsPage.qml";
    signal openedSettingsPage()
    function openSettingsPage()
    {
        stackView.push(settingsPage, {bus: bus})
        openedWelcomePage()
    }

    property string recorderPage: "Pages/Recorder/RecorderPage.qml";
    signal openedRecorderPage()
    function openRecorderPage(path)
    {
        stackView.push(recorderPage, {bus: bus, path: path})
        openedRecorderPage()
    }
}
