#ifndef APPLICATIONCONFIG_H
#define APPLICATIONCONFIG_H

#include <QString>
#include <QStringList>
#include <QGuiApplication>
#include <QDir>

namespace ApplicationConfig {
static const QString DataPath = "data";
static const QString RecordsPath = "records";
static const QString TestsPath = "tests";

static QString GetFullDataPath()
{
    QString appPath = QGuiApplication::applicationDirPath();
    QString dataPath = QDir(appPath).absoluteFilePath(ApplicationConfig::DataPath);
    QString recordsPath = QDir(dataPath).absoluteFilePath(ApplicationConfig::RecordsPath);
    return recordsPath;
}

static QString GetFullTestsPath()
{
    QString appPath = QGuiApplication::applicationDirPath();
    QString dataPath = QDir(appPath).absoluteFilePath(ApplicationConfig::DataPath);
    QString testsPath = QDir(dataPath).absoluteFilePath(ApplicationConfig::TestsPath);
    return testsPath;
}

    static const QString WaveFileExtension = "*.wav";

    static const QStringList WaveFileFilter = { WaveFileExtension };

    static const QString SettingsPath = "settings.ini";

    static QString GetFullSettingsPath()
    {
        QString appPath = QGuiApplication::applicationDirPath();
        QString dataPath = QDir(appPath).absoluteFilePath(ApplicationConfig::SettingsPath);
        return dataPath;
    }

    static const int RecordingFrequency =  8000;
    static const int RecordingBitsPerSample =  16;
    static const int RecordingChannelsCount =  1;
    static const QString RecordingAudioFormat = "audio/pcm";
    static const QString RecordingContainerFormat = "audio/x-wav";
    static const QString RecordingFileNameTemplate = "dd.MM.yyyy.hh.mm.ss.zzz";
}

#endif // APPLICATIONCONFIG_H
