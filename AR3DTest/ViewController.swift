//
//  ViewController.swift
//  AR3DTest
//
//  Created by 120v on 2018/2/12.
//  Copyright © 2018年 MQ. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setModelView()
        
//        setPlaneView()
        
//        setVideoView()
        
        setSCNCamera()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    //MARK: - 显示一个模型
    func setModelView() {
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    
    //MARK: - 如何在空间中放一个平面
    func setPlaneView() {
        // 1.设置场景视图的代理
        self.sceneView.delegate = self
        // 是否显示fps 或 timing等信息
        self.sceneView.showsStatistics = true
        //2. 创建场景
        let scene = SCNScene()
        //2.1  给场景视图绑定场景
        self.sceneView.scene = scene
        //3.  创建一个平面几何图形，高为0.1米，宽为0.1米
//        let plane = SCNPlane.init(width: 0.1, height: 0.1)
//        let pyramid = SCNPyramid.init(width: 0.1, height: 0.3, length: 0.5)
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        //4.  基于几何图形创建节点
        let node = SCNNode.init(geometry: box)
//  节点的创建不仅仅是基于平面，根据SCNGeometry头文件里可见，长方体、圆球、圆锥、圆环、金字塔形 等等都可以创建。有兴趣的可以换着尝试一下。
        //5.  创建渲染器
        let material = SCNMaterial()
        //  渲染器可以决定怎样渲染，这个 contents 属性可以设置很多东西，UILabel， UIImage，甚至 AVPlayer 都可以
        material.diffuse.contents = UIColor.white
        // 设置节点的位置, x,y,z轴位置(可以根据上面的3D图理解)
        node.position = SCNVector3Make(0, 0, -0.2)
        //5.5. 用渲染器对几何图形进行渲染
        box.materials = [material]
        //6. 为场景的根节点添加节点
        scene.rootNode.addChildNode(node)
    }
    
    //MARK: - 在空中放一个视频小短片
    func setVideoView() {
        // 1.设置场景视图的代理
        self.sceneView.delegate = self
        // 是否显示fps 或 timing等信息
        self.sceneView.showsStatistics = true
        //2. 创建场景
        let scene = SCNScene()
        //2.1  给场景视图绑定场景
        self.sceneView.scene = scene
        //3.  创建一个平面几何图形，高为0.1米，宽为0.1米
        let plane = SCNPlane.init(width: 0.1, height: 0.1)
        //4.  基于几何图形创建节点
        let node = SCNNode.init(geometry: plane)
 //  节点的创建不仅仅是基于平面，根据SCNGeometry头文件里可见，长方体、圆球、圆锥、圆环、金字塔形 等等都可以创建。有兴趣的可以换着尝试一下。
        node.position = SCNVector3Make(0, 0, -0.3); // 节点设置位置
        //5.  创建渲染器
        let material = SCNMaterial()
        // 注意，这里对渲染器做点事，渲染的不再是颜色，而是视频
        let url = "http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"
//        NSURL *url = [[NSBundle mainBundle] URLForResource:@"视频" withExtension:@"mp4"];
        //  创建AVPlayer准备渲染
        let player = AVPlayer.init(url: URL.init(string: url)!)
        material.diffuse.contents = player   //  渲染器可以决定怎样渲染，这个 contents 属性可以设置很多东西，UILabel， UIImage，甚至 AVPlayer 都可以
        node.position = SCNVector3Make(0, 0, -0.3)
        //5.5. 用渲染器对几何图形进行渲染
        plane.materials = [material]
        //6. 为场景的根节点添加节点
        scene.rootNode.addChildNode(node)
        player.play()
    }
    
    
    func setSCNCamera() {
        // 场景视图
        let scnView = SCNView.init(frame: view.bounds)
        scnView.backgroundColor = UIColor.black
        scnView.allowsCameraControl = true
        scnView.scene = SCNScene()
        view.addSubview(scnView)
        
        // 盒子1
        let box1 = SCNBox.init(width: 10, height: 10, length: 10, chamferRadius: 0)
        box1.firstMaterial?.diffuse.contents = UIImage.init(named: "timg")
        let boxNode1 = SCNNode()
        boxNode1.geometry = box1
        scnView.scene?.rootNode.addChildNode(boxNode1)
        
        // 盒子2
        let box2 = SCNBox.init(width: 10, height: 10, length: 10, chamferRadius: 0)
        box2.firstMaterial?.diffuse.contents = UIImage.init(named: "timg")
        let boxNode2 = SCNNode()
        boxNode2.geometry = box2
        boxNode2.position = SCNVector3Make(0, 10, -20)
        scnView.scene?.rootNode.addChildNode(boxNode2)
        
        // todoyy: 如何给六面体设置不同的image？
        
        // 添加照相机
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        //调节视角
        camera.fieldOfView = .pi*6 //  视角，默认60°【值越小，看到的物体细节越在前面，即被放大】
        camera.focalLength = 5    //  焦距，默认50mm【值越小，看到的物体越远】
        //设置视野远近范围
        camera.zNear = 45 // 相机能照到的最近距离，默认1m
        camera.zFar = 60 //相机能照到的最远的距离，默认100m
        //设置焦距
        camera.focusDistance = 45 // 焦距 默认2.5
        camera.focalBlurSampleCount = 1 // 设置聚焦时，模糊物体模糊度 默认0
        //设置正投影
        // 设置正投影【即：物体不论靠近或者远离，大小看起来都一样】
        camera.usesOrthographicProjection = true
        // 正投影比例 默认1【当且仅当usesOrthographicProjection == true 时有效】
        camera.orthographicScale = 20

        cameraNode.position = SCNVector3Make(0, 0, 50)
        scnView.scene?.rootNode.addChildNode(cameraNode)
    }
    

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
