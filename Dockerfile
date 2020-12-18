FROM openjdk:9
# Setup android SDK
RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1
RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip
RUN unzip android-sdk.zip 
RUN rm android-sdk.zip 
RUN mkdir sdk
RUN mkdir sdk/cmdline-tools
RUN mv cmdline-tools sdk/cmdline-tools/tools
ENV ANDROID_SDK_ROOT sdk

ENV PATH "$PATH:${ANDROID_SDK_ROOT}"
ENV PATH "$PATH:${ANDROID_SDK_ROOT}/cmdline-tools/tools/bin"
ENV PATH "$PATH:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin"

RUN echo y | sdkmanager "platforms;android-30" >/dev/null
RUN echo y | sdkmanager "platform-tools" >/dev/null
RUN echo y | sdkmanager "build-tools;30.0.0" >/dev/null

RUN yes | sdkmanager --licenses

# Setup Gradle
RUN wget --quiet --output-document=gradle.zip https://services.gradle.org/distributions/gradle-6.4.1-bin.zip
RUN unzip gradle.zip
RUN rm gradle.zip
ENV GRADLE_HOME  gradle-6.4.1
ENV PATH "$PATH:${GRADLE_HOME}/bin"

## Setup Emulator
# RUN sdkmanager "system-images;android-29;google_apis;x86"
# RUN avdmanager create avd -n test -k "system-images;android-29;google_apis;x86"
