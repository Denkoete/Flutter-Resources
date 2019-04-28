import 'package:flutter/material.dart';

import 'dart:async';

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ARKitImageDetection extends StatefulWidget {
  @override
  _ARKitImageDetectionState createState() => _ARKitImageDetectionState();
}

class _ARKitImageDetectionState extends State<ARKitImageDetection> {
  ARKitController arkitController;
  Timer timer;
  bool anchorWasFound = false;

  @override
  void dispose() {
    timer?.cancel();
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            ARKitSceneView(
              detectionImagesGroupName: 'AR Resources',
              onARKitViewCreated: onARKitViewCreated,
            ),
            anchorWasFound
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Point the camera at the earth image from the article about Earth on Wikipedia.',
                      style: Theme.of(context)
                          .textTheme
                          .headline
                          .copyWith(color: Colors.white),
                    ),
                  ),
          ],
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = onAnchorWasFound;
  }

  void onAnchorWasFound(ARKitAnchor anchor) {
    if (anchor is ARKitImageAnchor) {
      setState(() => anchorWasFound = true);

      final material = ARKitMaterial(
        lightingModelName: ARKitLightingModel.lambert,
        diffuse: ARKitMaterialProperty(image: 'earth.jpg'),
      );
      final sphere = ARKitSphere(
        materials: [material],
        radius: 0.1,
      );

      final earthPosition = anchor.transform.getColumn(3);
      final node = ARKitNode(
        geometry: sphere,
        position:
            vector.Vector3(earthPosition.x, earthPosition.y, earthPosition.z),
        rotation: vector.Vector4(0, 0, 0, 0),
      );
      arkitController.add(node);

      timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
        final old = node.rotation.value;
        final rotation = vector.Vector4(old.x, old.y + 1, old.z, old.w + 0.05);
        node.rotation.value = rotation;
      });
    }
  }
}
