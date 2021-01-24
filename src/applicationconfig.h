#ifndef APPLICATIONCONFIG_H
#define APPLICATIONCONFIG_H

#include <QString>
#include <QStringList>
#include <QGuiApplication>
#include <QDir>
#include <QStandardPaths>

namespace ApplicationConfig {
    static const QString DataPath = "data";
    static const QString RecordsPath = "records";
    static const QString TestsPath = "tests";

    static QString GetFullDataPath()
    {
#ifdef ANDROID
        QString recordsPath = QStandardPaths::writableLocation(QStandardPaths::AppLocalDataLocation);
//        QString recordsPath = QStandardPaths::writableLocation(QStandardPaths::MusicLocation);
#else
        QString appPath = QGuiApplication::applicationDirPath();
        QString dataPath = QDir(appPath).absoluteFilePath(ApplicationConfig::DataPath);
        QString recordsPath = QDir(dataPath).absoluteFilePath(ApplicationConfig::RecordsPath);
#endif
        return recordsPath;
    }

    static QString GetFullTestsPath()
    {
#ifdef ANDROID
        QString testsPath = QStandardPaths::writableLocation(QStandardPaths::MusicLocation);
#else
        QString appPath = QGuiApplication::applicationDirPath();
        QString dataPath = QDir(appPath).absoluteFilePath(ApplicationConfig::DataPath);
        QString testsPath = QDir(dataPath).absoluteFilePath(ApplicationConfig::TestsPath);
#endif
        return testsPath;
    }

    static const QString WaveFileExtension = "*.wav";

    static const QStringList WaveFileFilter = { WaveFileExtension };

    static const QString SettingsPath = "settings.ini";

    static QString GetFullSettingsPath()
    {
#ifdef ANDROID
        QString appPath = QStandardPaths::writableLocation(QStandardPaths::AppLocalDataLocation);
        QString dataPath = QDir(appPath).absoluteFilePath(ApplicationConfig::SettingsPath);
#else
        QString appPath = QGuiApplication::applicationDirPath();
        QString dataPath = QDir(appPath).absoluteFilePath(ApplicationConfig::SettingsPath);
#endif
        return dataPath;
    }

    static const QString ResultsPath = "results.txt";

    static QString GetFullResultsPath()
    {
#ifdef ANDROID
        QString appPath = QStandardPaths::writableLocation(QStandardPaths::AppLocalDataLocation);
        QString dataPath = QDir(appPath).absoluteFilePath(ApplicationConfig::ResultsPath);
#else
        QString appPath = QGuiApplication::applicationDirPath();
        QString dataPath = QDir(appPath).absoluteFilePath(ApplicationConfig::ResultsPath);
#endif
        return dataPath;
    }

    static const int RecordingFrequency =  8000;
    static const int RecordingBitsPerSample =  16;
    static const int RecordingChannelsCount =  1;
    static const QString RecordingAudioFormat = "audio/pcm";
    static const QString RecordingFileFormat = ".wav";
    static const QString RecordingContainerFormat = "audio/x-wav";
//    static const QString RecordingContainerFormat = "wav";
    static const QString RecordingFileNameTemplate = "dd.MM.yyyy.hh.mm.ss.zzz";
}

#endif // APPLICATIONCONFIG_H
