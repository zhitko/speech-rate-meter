import QtQuick 2.14
import QtQuick.Controls 2.14

Item {
    id: bus

    property var stackView

    property string metricsPage: "Pages/Metrics/MetricsPage.qml";
    signal openedMetricsPage(string path)
    function openMetricsPage(path)
    {
        console.log("Bus: openMetricsPage " + path);
        stackView.push(metricsPage, {name: "Metrics", path: path, bus: bus})
        openedMetricsPage(path)
    }

    property string welcomePage: "Pages/Welcome/WelcomePage.qml";
    signal openedWelcomePage()
    function openWelcomePage()
    {
        console.log("Bus: openWelcomePage");
        stackView.clear();
//        stackView.push(welcomePage, {bus: bus})
//        openedWelcomePage()
        stackView.push(recorderPage, {bus: bus})
        openedRecorderPage()
    }

    property string settingsPage: "Pages/Settings/SettingsPage.qml";
    signal openedSettingsPage()
    function openSettingsPage()
    {
        console.log("Bus: openSettingsPage");
        stackView.push(settingsPage, {bus: bus})
        openedSettingsPage()
    }

    property string recorderPage: "Pages/Recorder/RecorderPage.qml";
    signal openedRecorderPage()
    function openRecorderPage(path)
    {
        console.log("Bus: openRecorderPage " + path);
        stackView.push(recorderPage, {bus: bus, path: path})
        openedRecorderPage()
    }
    function reopenRecorderPage(path)
    {
        console.log("Bus: reopenRecorderPage " + path);
        stackView.pop();
        stackView.push(recorderPage, {bus: bus, path: path, autostart: true})
        openedRecorderPage()
    }
}
