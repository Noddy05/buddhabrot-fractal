
int iterations = 50;

int[][] densityMap;
int heighestDensity = 1;

void setup() {
  size(800, 800, P2D);
  background(5);
  densityMap = new int[width][height];
}

void draw() {
  //Depending on the iterations it can be beneficial to do multiple values for c each frame
  for (int c = 0; c < 15000; c++) {
    float cx = random(-2, 2);
    float cy = random(-2, 2);

    PVector[] path = CalculatePathForC(cx, cy);

    if (path[iterations - 1] == null)
      FillDensityMap(path);
  }
  
  CalculateMaxDensity();
  DrawDensityMap();
}

PVector[] CalculatePathForC(float cx, float cy){
  float nx = cx;
  float ny = cy;
  PVector[] path = new PVector[iterations];
  for (int i = 0; i < iterations; i++) {
    float calculatedA = nx * nx - ny * ny + cx;
    ny = 2 * nx * ny + cy;
    nx = calculatedA;

    path[i] = new PVector(nx, ny);
    if (nx * nx + ny * ny > 4)
      break;
  }
  
  return path;
}

void FillDensityMap(PVector[] path) {
  for (int i = 0; i < iterations; i++) {
    PVector point = path[i];
    if (point == null)
      break;

    int x = int(((point.x + 2) / 4) * width);
    int y = int(((point.y + 2) / 4) * height);

    if (x >= 0 && x < width && y >= 0 && y < height)
      densityMap[x][y]++;
  }
}

void CalculateMaxDensity() {
  for (int y = 0; y < height; y++)
    for (int x = 0; x < width; x++)
      if (densityMap[y][x] > heighestDensity)
        heighestDensity = densityMap[y][x];
}

void DrawDensityMap() {
  for (int y = 0; y < height; y++)
  {
    for (int x = 0; x < width; x++)
    {
      int c = densityMap[y][x] * 255 / heighestDensity;
      set(x, y, color(c));
    }
  }
}
