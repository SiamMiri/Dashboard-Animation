import QtQuick 2.15
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.1
import QtMultimedia 5.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtGraphicalEffects 1.15


import Auto.com 5.5

Window {
    width: 1000
    height: 400
    visible: true
    title: qsTr("Auto Dashboard")
    color: "#ffffff"

    property double startTime: 0


    GasGeben {
        id: gg
    }
    Anim{
        id:anim
    }

    Label{
        id:lblgeschwindigleit
        x:0
        y:0
        text: "Geschwindigkeit"
    }

    TextField{
        id: geschwindigleit
        x: 0
        y: 22
        width: 94
        height: 30
        text: "0"
        validator: DoubleValidator {bottom: 1; top: 100000}
        readOnly: true

    }
    Label{
        id:lblgear
        x:145
        y:0
        text: "Gear"
    }

    TextField{
        id: gear
        x: 145
        y: 25
        width: 38
        height: 30
        readOnly: true
    }
    Label{
        id:lblstatus
        x:0
        y:175
        text: "Auto Status"
    }

    TextField{
        id: status
        x: 0
        y: 197
        width: 60
        height: 30
        text: gg.AutoStatus
        readOnly: true
    }

    Label {
        id: label_KM
        x: 0
        y: 67
        width: 73
        height: 13
        text: qsTr("Gesamtkilometerzahl")
    }

    TextField {
        id: tf_km
        x: 0
        y: 86
        width: 94
        height: 30

        validator: DoubleValidator {
            bottom: 1
            top: 100000
        }

        readOnly: true
    }

    TextField {
        id: tf_fuelRem
        x: 145
        y: 86
        width: 94
        height: 30
        text: "70"
        validator: DoubleValidator {
            bottom: 1
            top: 100000
        }

        readOnly: true
    }

    Label {
        id: label
        x: 145
        y: 67
        width: 94
        height: 13
        text: qsTr("Fuel")
    }

    Label {
        id: label1
        x: 300
        y: 0
        width: 64
        height: 13
        text: qsTr("Drehzahl")
    }

    TextField {
        id: tf_rpm
        x: 300
        y: 24
        width: 48
        height: 30

        readOnly: true
    }

    Label {
        id: label_mileage
        x: 300
        y: 67
        width: 64
        height: 13
        text: qsTr("Verbrauch")
    }

    TextField {
        id: tf_mileage
        x: 300
        y: 86
        width: 94
        height: 30

        validator: DoubleValidator {
            bottom: 1
            top: 100000
        }

        readOnly: true
    }

    AnimatedImage{
        id:road
        x: 500
        y: 0
        width: 600
        height: 400
        speed: geschwindigleit.text/20
        fillMode: Image.Stretch
        source: "Road.gif"
    }

    Image {
        id: speedometer
        x: 5
        y: 240
        width: 100
        height: 100
        source: "speedometer.png"

        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: needle
        x: 30
        y: 275
        width: 50
        height: 50
        source: "needle3.png"
        fillMode: Image.PreserveAspectFit
        transform: Rotation{id:testrotatio}
    }

    RotationAnimation {
        id: rotateBremse
        target:needle
        property: "rotation"
        from: geschwindigleit.text
        to: geschwindigleit.text - 1
        duration: 50
        direction: RotationAnimation.Counterclockwise
    }

    Image {
        id: gasimage
        x: 920
        y: 300
        width: 100
        height: 100
        source: "GasImage.png"
        fillMode: Image.PreserveAspectFit
    }

    MouseArea{
        id: moargas
        anchors.fill: gasimage
        enabled: false

        onPressed: {

            soundstartengine.stop()
            soundfahrenohnegasgeben.stop()
            soundbrakespeedhigh.stop()
            soundbrakespeedlow.stop()

            if(status.text === "R")
            {
                soundreverse.play()

            }else if(status.text === "D")
            {
                soundfahren.play()
            }
        }

        onReleased: {
            soundfahren.stop()
            soundfahrenohnegasgeben.play()
            soundreverse.stop()

        }
    }

    Timer {
        id: timergas
        interval: 80
        repeat: true
        triggeredOnStart: true
        running: moargas.containsMouse

        onTriggered: {
            if(status.text === "R"){

                geschwindigleit.text = gg.Reversegear
                gg.Reversegear = geschwindigleit.text

                anim.start()

                gg.AutoStatus =status.text

                gg.GearZahl = gear.text
                gear.text = gg.GearZahl

                tf_km.text = gg.KmZahl
                gg.KmZahl = tf_km.text

                gg.Mileage = tf_mileage.text
                tf_mileage.text = gg.Mileage


                gg.FuelRem = tf_fuelRem.text
                tf_fuelRem.text = gg.FuelRem

                tf_rpm.text = gg.Drehzahl
                gg.Drehzahl = tf_rpm.text

                if(tf_fuelRem.text < 10 && tf_fuelRem.text > 2)
                {
                    label_FuelIndicator.text="Kraftstoff fast Leer !!"
                    rect_FuelIndicator.color ="yellow"

                }else if (tf_fuelRem.text >= 1 && tf_fuelRem.text <= 2){

                    label_FuelIndicator.text="Refill Tank"
                    rect_FuelIndicator.color ="red"
                    //moargas.enabled =false
                } else if (tf_fuelRem.text < 1){

                    label_FuelIndicator.color = "red"
                    timergas.stop()
                    moargas.enabled = false
                    btnstart.enabled = false
                    btndrive.enabled = false
                    btndriveback.enabled = false
                    //btnneutral.enabled = false
                    //btnpark.pressed()
                    btnpark.enabled = false
                }

                if((geschwindigleit.text < 1) && (tf_fuelRem.text > 2 ))
                {
                    btnpark.enabled = true
                    btndriveback.enabled = true
                    btndrive.enabled = true
                    btnpark.enabled = true
                }else {
                    btnpark.enabled = false
                    btndriveback.enabled = false
                    btndrive.enabled = false
                    btnpark.enabled = false
                }
            }else if (status.text === "D" ){

                //anim.stop()
                geschwindigleit.text = gg.GasGeben
                gg.GasGeben = geschwindigleit.text
                //rotateGas.start()

                anim.start()

                gg.AutoStatus =status.text

                gg.GearZahl = gear.text
                gear.text = gg.GearZahl

                tf_km.text = gg.KmZahl
                gg.KmZahl = tf_km.text


                gg.Mileage = tf_mileage.text
                tf_mileage.text = gg.Mileage


                gg.FuelRem = tf_fuelRem.text
                tf_fuelRem.text = gg.FuelRem

                tf_rpm.text = gg.Drehzahl
                gg.Drehzahl = tf_rpm.text

                if(tf_fuelRem.text<10 && tf_fuelRem.text > 2)
                {
                    label_FuelIndicator.text="Kraftstoff fast Leer !!"
                    rect_FuelIndicator.color ="yellow"


                }else if (tf_fuelRem.text >= 1 && tf_fuelRem.text<= 2){

                    label_FuelIndicator.text="Refill Tank"
                    rect_FuelIndicator.color ="red"
                    //moargas.enabled =false

                } else if (tf_fuelRem.text < 1){

                    label_FuelIndicator.color = "red"
                    timergas.stop()
                    moargas.enabled = false
                    btnstart.enabled = false
                    btndrive.enabled = false
                    btndriveback.enabled = false
                    //btnneutral.enabled = false
                    btnpark.pressed()
                    btnpark.enabled = false
                }

                if((geschwindigleit.text < 1) && (tf_fuelRem.text > 2 )){

                    btnpark.enabled = true
                    btndriveback.enabled = true
                    btndrive.enabled = true
                    btnpark.enabled = true

                }else {
                    btnpark.enabled = false
                    btndriveback.enabled = false
                    btndrive.enabled = false
                    btnpark.enabled = false
                }
            }
        }
    }

    //Keyboard Bereich\\

    Item {
        id: test1
        focus: true
        Keys.onPressed: {

            if(event.key === Qt.Key_S){
                if(btnstart.enabled === true){
                    btnstart.clicked()
                    //console.log("s");
                }
            }else if (event.key === Qt.Key_D){

                //console.log("d");
                if(geschwindigleit.text < 1 && btnstart.enabled === false){
                    btndrive.clicked()
                }

            }else if (event.key === Qt.Key_W){

                //console.log("w");

                if (tf_fuelRem.text > 1){

                    timergas.start()

                    //
                    soundstartengine.stop()
                    soundfahrenohnegasgeben.stop()
                    soundbrakespeedhigh.stop()
                    soundbrakespeedlow.stop()

                    if(status.text === "R")
                    {
                        if(soundreverse.playing === false){
                            soundreverse.play()
                        }

                    }else if(status.text === "D")
                    {
                        if(soundfahren.playing === false){
                            soundfahren.play()
                        }
                    }
                    //

                }else{

                    label_FuelIndicator.color = "red"
                    timergas.stop()
                    moargas.enabled = false
                    btnstart.enabled = false
                    btndrive.enabled = false
                    btndriveback.enabled = false
                    //btnneutral.enabled = false
                    btnpark.enabled = false
                }

            }else if (event.key === Qt.Key_B){

                //console.log("w");
                timerbremse.start()
                //
                soundfahren.stop()
                soundfahrenohnegasgeben.stop()
                soundreverse.stop()

                if(geschwindigleit.text > 120)
                {
                    if(soundbrakespeedhigh.playing === false){
                        soundbrakespeedhigh.play()
                    }
                }else if( geschwindigleit.text > 40 && geschwindigleit.text <= 120){

                    if(soundbrakespeedlow.playing === false){
                        soundbrakespeedlow.play()
                    }
                }
                //

            }else if (event.key === Qt.Key_R && btnstart.enabled === false ){

                //console.log("r");
                if(geschwindigleit.text < 1){
                    btndriveback.clicked()
                }

            }else if (event.key === Qt.Key_P){

                //console.log("p");
                btnpark.clicked()
            }
        }

        Keys.onReleased: {

            if(event.key === Qt.Key_S){

                //console.log("s released");

            }else if (event.key === Qt.Key_D){

                //console.log("d released");

            }else if (event.key === Qt.Key_W){


                //console.log("w released");
                soundfahren.stop()
                soundreverse.stop()

                if(soundfahrenohnegasgeben.playing === false && geschwindigleit.text > 1){
                    soundfahrenohnegasgeben.play()
                }

                timergas.stop()

            }else if (event.key === Qt.Key_B){

                //console.log("b released");
                timerbremse.stop()
                soundbrakespeedhigh.stop()
                soundbrakespeedlow.stop()

            }else if (event.key === Qt.Key_R){

                //console.log("r released");

            }else if (event.key === Qt.Key_P){

                //console.log("n  released");
            }
        }
    }

    Image {
        id: bremse
        x: 500
        y: 300
        width: 100
        height: 100
        source: "Bremse.png"
        fillMode: Image.PreserveAspectFit
    }

    MouseArea{
        id: moarbremse
        anchors.fill: bremse
        enabled: false

        onPressed: {
            soundfahren.stop()
            soundfahrenohnegasgeben.stop()
            soundreverse.stop()

            if(geschwindigleit.text > 120)
            {
                soundbrakespeedhigh.play()

            }else if( geschwindigleit.text > 40 && geschwindigleit.text <= 120){

                soundbrakespeedlow.play()

            }else {
                //bis jetz Nicht
            }
        }
        onClicked: {

        }

        onReleased: {
            soundbrakespeedhigh.stop()
            soundbrakespeedlow.stop()
        }
    }

    Timer {
        id: timerbremse
        interval: 10
        repeat: true
        triggeredOnStart: true
        running: moarbremse.containsMouse

        onTriggered: {

            gg.AutoStatus =status.text

            if(status.text=="D"){

                gg.Bremsen = geschwindigleit.text
                rotateBremse.start()
                geschwindigleit.text = gg.Bremsen

                gg.GearZahl = gear.text
                gear.text = gg.GearZahl

                tf_km.text = gg.KmZahl

                tf_rpm.text = gg.Drehzahl
                gg.Drehzahl = tf_rpm.text

                if(geschwindigleit.text < 1)
                {
                    btnpark.enabled = true
                    btndriveback.enabled = true
                }else{
                    btnpark.enabled = false
                    btndriveback.enabled = false
                }
            }else if(status.text=="R"){

                gg.RevBremsen = geschwindigleit.text
                rotateBremse.start()
                geschwindigleit.text = gg.RevBremsen

                gg.GearZahl = gear.text
                gear.text = gg.GearZahl

                tf_km.text = gg.KmZahl

                tf_rpm.text = gg.Drehzahl
                gg.Drehzahl = tf_rpm.text

                if(geschwindigleit.text < 1)
                {
                    btnpark.enabled = true
                    btndriveback.enabled = true
                    btndrive.enabled = true
                }else{
                    btnpark.enabled = false
                    btndriveback.enabled = false
                    btndrive.enabled = false
                }
            }
        }
    }

    Timer{
        id: friktion
        interval: 1000
        repeat: true
        triggeredOnStart: true
        running: moargas.pressAndHoldInterval && moarbremse.pressAndHoldInterval
        onTriggered: {

            if((status.text=="D") && geschwindigleit.text >= 0)
            {
                gg.Bremsen = geschwindigleit.text
                //rotateBremse.start()

                geschwindigleit.text = gg.Bremsen
                anim.start()

                gg.AutoStatus =status.text
                tf_km.text = gg.KmZahl
                gg.KmZahl = tf_km.text

                tf_mileage.text = gg.Mileage
                gg.Mileage = tf_mileage.text


                tf_fuelRem.text = gg.FuelRem
                gg.FuelRem = tf_fuelRem.text

                tf_rpm.text = gg.Drehzahl
                gg.Drehzahl = tf_rpm.text

                if(tf_fuelRem.text<10 && tf_fuelRem.text > 2)
                {
                    label_FuelIndicator.text="Kraftstoff fast Leer !!"
                    rect_FuelIndicator.color ="yellow"


                }
                else if (tf_fuelRem.text<= 2)
                {
                    label_FuelIndicator.text="Refill Tank"
                    rect_FuelIndicator.color ="red"
                    //geschwindigleit.text = 0
                    //moargas.enabled =false
                }
            }
            else if((status.text=="R") && geschwindigleit.text >= 0)
            {
                gg.RevBremsen = geschwindigleit.text + 1
                geschwindigleit.text = gg.RevBremsen

                anim.start()

                gg.AutoStatus = status.text

                tf_km.text = gg.KmZahl
                gg.KmZahl = tf_km.text

                gg.Mileage = tf_mileage.text
                tf_mileage.text = gg.Mileage

                gg.FuelRem = tf_fuelRem.text
                tf_fuelRem.text = gg.FuelRem

                tf_rpm.text = gg.Drehzahl
                gg.Drehzahl = tf_rpm.text

                if(tf_fuelRem.text<10 && tf_fuelRem.text > 2)
                {
                    label_FuelIndicator.text="Kraftstoff fast Leer !!"
                    rect_FuelIndicator.color ="yellow"


                }
                else if (tf_fuelRem.text<= 2)
                {
                    label_FuelIndicator.text="Refill Tank"
                    rect_FuelIndicator.color ="red"
                    //geschwindigleit.text = 0
                    //moargas.enabled =false
                }
            }
        }
    }

    AnimatedImage{
        id:roadback
        x: 700
        y: 0
        width: 150
        height: 100

        visible: false
        speed: geschwindigleit.text / 15
        fillMode: Image.Stretch
        source: "RearView.gif"
    }

    SoundEffect {
        id: soundstartengine
        source: "start.wav"
    }

    SoundEffect {
        id: soundfahren
        source: "Fahren.wav"
    }

    SoundEffect{
        id:soundfahrenohnegasgeben
        source: "Fahrenohnegasgeben.wav"
    }


    SoundEffect{
        id: soundbrakespeedhigh
        source: "brakeHighSpeed.wav"
    }

    SoundEffect{
        id: soundbrakespeedlow
        source: "brakeLowSpeed.wav"
    }
    SoundEffect{
        id: soundreverse
        source: "Reverse.wav"
    }

    RoundButton{
        id : btnpark
        x: 950
        y: 150
        width: 30
        height: 30
        palette {
            button: "gray"
            buttonText: "red"
        }

        text: "P"
        onClicked: {
            roadback.visible = false
            road.visible = true

            moargas.enabled = false
            palette.button = "green"
            btnpark.palette.buttonText = "red"

            btndriveback.palette.button = "gray"
            //btnneutral.palette.button = "gray"
            btndrive.palette.button = "gray"

            btndriveback.palette.buttonText = "green"
            //btnneutral.palette.buttonText = "green"
            btndrive.palette.buttonText = "green"


            //btnneutral.enabled = false
            btndriveback.enabled = false
            btndrive.enabled = false

            btnstart.enabled = true

            anim.pause()
            geschwindigleit.text = 0

            soundfahren.stop()
            soundstartengine.stop()
            soundreverse.stop()

            status.text = "P"
        }
    }

    RoundButton{
        id : btndriveback
        x: 950
        y: 185
        width: 30
        height: 30
        enabled: false
        palette {
            button: "gray"
            buttonText: "green"
        }

        text: "R"

        onClicked: {
            road.enabled = false
            roadback.visible = true


            palette.button = "green"
            palette.buttonText = "red"

            btnpark.palette.button = "gray"
            btndrive.palette.button = "gray"
            //btnneutral.palette.button = "gray"

            btnpark.palette.buttonText = "green"
            btndrive.palette.buttonText = "green"
            //btnneutral.palette.buttonText = "green"

            moargas.enabled = true
            moarbremse.enabled = true


            status.text = "R"

        }
    }

    /*
    RoundButton{
        id : btnneutral
        x: 950
        y: 220
        width: 30
        height: 30
        enabled: false
        palette {
            button: "gray"
            buttonText: "green"
        }

        text: "N"
        onClicked: {
            roadback.visible = false
            road.visible = true

            palette.button = "green"
            palette.buttonText = "red"

            btndriveback.palette.button = "gray"
            btndrive.palette.button = "gray"
            btnpark.palette.button = "gray"


            btndriveback.palette.buttonText = "green"
            btndrive.palette.buttonText = "green"
            btnpark.palette.buttonText = "green"




            status.text = "N"

            moargas.enabled = false

        }
    }

    */
    RoundButton{
        id : btndrive
        x: 950
        y: 220
        width: 30
        height: 30
        enabled: false
        palette {
            button: "gray"
            buttonText: "green"
        }

        text: "D"
        onClicked: {
            roadback.visible = false
            road.visible = true

            palette.button = "green"
            palette.buttonText = "red"

            btndriveback.palette.button = "gray"
            //btnneutral.palette.button = "gray"
            btnpark.palette.button = "gray"


            btndriveback.palette.buttonText = "green"
            //btnneutral.palette.buttonText = "green"
            btnpark.palette.buttonText = "green"

            moargas.enabled = true
            moarbremse.enabled = true
            anim.start()

            status.text = "D"
        }
    }

    RoundButton{
        id : btnstart
        x: 930
        y: 10
        width: 70
        height: 70
        palette {
            button: "gray"
            buttonText: "green"
        }

        text: "Start"
        onClicked: {
            road.visible = true
            roadback.enabled = false

            //btnneutral.enabled = true

            btndrive.enabled = true
            btnpark.enabled = true
            btndriveback.enabled = true
            btnstart.enabled = false
            btnstart.palette.buttonText = "red"

            soundstartengine.play()

        }

        /*
        onPressed: {
            soundstartengine.play()
        }
        */
    }

    Rectangle {
        id: rect_FuelIndicator
        x: 181
        y: 64
        width: 20
        height: 20
        radius: 10
        color: "green"
    }

    Label {
        id: label_FuelIndicator
        x: 160
        y: 117
        width: 99
        height: 21
    }

    // Fuel area \\

    Timer {
        running: true
        repeat: true
        interval: 1000
        onTriggered: gauge.value = tf_fuelRem.text
    }


    Gauge {
        x:500
        id: gauge
        minimumValue: 0
        maximumValue: 70
        width: 80
        height: 200
        //anchors.fill: parent
        anchors.margins: 5
        font.pixelSize: 15

        value: 70
        Behavior on value {
            NumberAnimation {
                duration: 1000
            }
        }

        formatValue: function(value) {
            return value.toFixed(0);
        }

        style: GaugeStyle {
            valueBar: Rectangle {
                implicitWidth: 5
                color: Qt.rgba(1- gauge.value / gauge.maximumValue,gauge.value / gauge.maximumValue, 0, 1)
            }
        }
    }

    Image {
        id: fueliconn
        x:545
        y:10
        width: 25
        height: 25
        source: "fuel-icon.png"
    }


    Timer {
        running: true
        repeat: true
        interval: 10
        onTriggered: {
            if(status.text=="R"){
                speedometer2.value = gg.Reversegear
            }else if(status.text=="D"){
                speedometer2.value = gg.GasGeben
            }
        }
    }

    CircularGauge {

        id:speedometer2
        x:500
        y:150
        width: 150
        height: 250
        minimumValue: 0
        maximumValue : 200

        style: CircularGaugeStyle {
            minimumValueAngle: -90
            maximumValueAngle: 90
            labelStepSize: 25

            tickmarkLabel:  Text {
                font.pixelSize: Math.max(6, outerRadius * 0.1)
                text: styleData.value
                color: styleData.value >= 160 ? "#e34c22" : "#e5e5e5"
                antialiasing: true
            }

            needle: Rectangle {

                y: outerRadius * 0.15
                implicitWidth: outerRadius * 0.03
                implicitHeight: outerRadius * 0.9
                antialiasing: true
                color: Qt.rgba(0.66, 0.3, 0, 1)

            }
        }
    }

    RoundButton{
        id : geardisplay
        x: 620
        y: 190
        width: 30
        height: 30
        enabled: false
        palette {
            button: Qt.rgba(1, 0, 0, 1)
            buttonText: "black"
        }

        text: gear.text
    }

    Label{
        id:gesamtkilometerzahl
        x:540
        y:300
        text: tf_km.text + "km"
        color: "black"
    }
}
