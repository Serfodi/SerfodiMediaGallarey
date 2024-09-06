//
//  GalleryViewControllerTests.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

@testable import SerfodiMediaGallarey
import XCTest

class GalleryViewControllerTests: XCTestCase
{
    // MARK: Subject under test
    
    var sut: GalleryViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        window = UIWindow()
        setupGalleryViewController()
    }
    
    override func tearDown()
    {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupGalleryViewController()
    {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
    }
    
    func loadView()
    {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Test doubles
    
    class GalleryBusinessLogicSpy: GalleryBusinessLogic
    {
        var doSomethingCalled = false
        
        func doSomething(request: Gallery.Something.Request)
        {
            doSomethingCalled = true
        }
    }
    
    // MARK: Tests
    
    func testShouldDoSomethingWhenViewIsLoaded()
    {
        // Given
        let spy = GalleryBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.doSomethingCalled, "viewDidLoad() should ask the interactor to do something")
    }
    
    func testDisplaySomething()
    {
        // Given
        let viewModel = Gallery.Something.ViewModel()
        
        // When
        loadView()
        sut.displaySomething(viewModel: viewModel)
        
        // Then
        //XCTAssertEqual(sut.nameTextField.text, "", "displaySomething(viewModel:) should update the name text field")
    }
}
