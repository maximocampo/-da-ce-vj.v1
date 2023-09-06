
//void tang2(int[] depth, float factor) {
//  pushMatrix();
//  fill(meshcolor[0], meshcolor[1], meshcolor[2]);
//  noStroke();

//  // Store the current frame's vertex data
//  ArrayList<PVector> currentFrameVertices = new ArrayList<>();

//  for (int y = 0; y < kinect.height - meshSkip; y += meshSkip) {
//    for (int x = 0; x < kinect.width - meshSkip; x += meshSkip) {
//      int offset = x + y * kinect.width;

//      float z = ((factor - depth[offset] * factor * 2)) - zDist;
//      float znext = ((factor - depth[offset + meshSkip * kinect.width] * factor * 2)) - zDist;
//      float zright = ((factor - depth[offset + meshSkip] * factor * 2)) - zDist;
//      float zdiag = ((factor - depth[offset + meshSkip * kinect.width + meshSkip] * factor * 2)) - zDist;

//      if (depth[offset] < kthresh) {
//        currentFrameVertices.add(new PVector(x * factor, y * factor, z));
//        currentFrameVertices.add(new PVector(x * factor, (y + meshSkip) * factor, znext));
//        currentFrameVertices.add(new PVector((x + meshSkip) * factor, y * factor, zright));
//        currentFrameVertices.add(new PVector((x + meshSkip) * factor, y * factor, zright));
//        currentFrameVertices.add(new PVector(x * factor, (y + meshSkip) * factor, znext));
//        currentFrameVertices.add(new PVector((x + meshSkip) * factor, (y + meshSkip) * factor, zdiag));
//      }
//    }
//  }

//  // Add the current frame's vertex data to the buffer
//  echoBuffer.add(0, currentFrameVertices);

//  // Remove the oldest frame if the buffer size exceeds the desired echo count multiplied by the frames between each echo
//  if (echoBuffer.size() > echoCount * framesBetweenEchoes) {
//    echoBuffer.remove(echoBuffer.size() - 1);
//  }

//  // Render the frames in the buffer
//  for (int i = 0; i < echoBuffer.size(); i++) {
//    if (i % framesBetweenEchoes == 0) {
//      ArrayList<PVector> frameVertices = echoBuffer.get(i);
//      beginShape(TRIANGLES);
//      for (PVector vertex : frameVertices) {
//        vertex(vertex.x, vertex.y, vertex.z);
//        normal(0,0,10);
//      }
//      endShape();
//    }
//  }

//  popMatrix();
//  frameCounter++;
//}
