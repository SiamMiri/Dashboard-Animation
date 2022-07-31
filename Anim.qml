import QtQuick.Layouts 1.1
import QtQuick 2.15

ParallelAnimation{

    RotationAnimation {
        id: rotateGas
        target:needle
        property: "rotation"
        //from: 0
        to: geschwindigleit.text
        duration: 0
        direction: RotationAnimation.Clockwise
    }

    RotationAnimation {
        id: rotateBremse
        target:needle
        property: "rotation"
        from: geschwindigleit.text
        to: geschwindigleit.text - 1
        duration: 100
        direction: RotationAnimation.Counterclockwise
    }
}

