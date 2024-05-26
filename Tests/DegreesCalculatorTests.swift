import XCTest
@testable import SwiftUIFun

final class DegreesCalculatorTests: XCTestCase {

    func testClockwiseCalculationsInFirstHalf() {
        let sut = makeSUT(start: 0, end: 180, direction: .clockwise)
        expect(sut: sut, degrees: 0, forPercent: 0)
        expect(sut: sut, degrees: 45, forPercent: 25)
        expect(sut: sut, degrees: 90, forPercent: 50)
        expect(sut: sut, degrees: 135, forPercent: 75)
        expect(sut: sut, degrees: 180, forPercent: 100)
    }
    
    func testClockwiseCalculationsInSecondHalf() {
        let sut = makeSUT(start: 200, end: 320, direction: .clockwise)
        expect(sut: sut, degrees: 200, forPercent: 0)
        expect(sut: sut, degrees: 230, forPercent: 25)
        expect(sut: sut, degrees: 260, forPercent: 50)
        expect(sut: sut, degrees: 290, forPercent: 75)
        expect(sut: sut, degrees: 320, forPercent: 100)
    }
    
    func testClockwiseCalculationsForBothHalves() {
        let sut = makeSUT(start: 40, end: 280, direction: .clockwise)
        expect(sut: sut, degrees: 40, forPercent: 0)
        expect(sut: sut, degrees: 100, forPercent: 25)
        expect(sut: sut, degrees: 160, forPercent: 50)
        expect(sut: sut, degrees: 220, forPercent: 75)
        expect(sut: sut, degrees: 280, forPercent: 100)
    }
    
    func testClockwiseCalculationsAcrossZero() {
        let sut = makeSUT(start: 340, end: 40, direction: .clockwise)
        expect(sut: sut, degrees: 340, forPercent: 0)
        expect(sut: sut, degrees: 355, forPercent: 25)
        expect(sut: sut, degrees: 10, forPercent: 50)
        expect(sut: sut, degrees: 25, forPercent: 75)
        expect(sut: sut, degrees: 40, forPercent: 100)
    }
    
    func testCounterClockwiseCalculationsInFirstHalf() {
        let sut = makeSUT(start: 0, end: 180, direction: .counterClockwise)
        expect(sut: sut, degrees: 0, forPercent: 0)
        expect(sut: sut, degrees: 315, forPercent: 25)
        expect(sut: sut, degrees: 270, forPercent: 50)
        expect(sut: sut, degrees: 225, forPercent: 75)
        expect(sut: sut, degrees: 180, forPercent: 100)
    }
    
    func testCounterClockwiseCalculationsInSecondHalf() {
        let sut = makeSUT(start: 200, end: 320, direction: .counterClockwise)
        expect(sut: sut, degrees: 200, forPercent: 0)
        expect(sut: sut, degrees: 140, forPercent: 25)
        expect(sut: sut, degrees: 80, forPercent: 50)
        expect(sut: sut, degrees: 20, forPercent: 75)
        expect(sut: sut, degrees: 320, forPercent: 100)
    }
    
    func testCounterClockwiseCalculationsForBothHalves() {
        let sut = makeSUT(start: 40, end: 280, direction: .counterClockwise)
        expect(sut: sut, degrees: 40, forPercent: 0)
        expect(sut: sut, degrees: 10, forPercent: 25)
        expect(sut: sut, degrees: 340, forPercent: 50)
        expect(sut: sut, degrees: 310, forPercent: 75)
        expect(sut: sut, degrees: 280, forPercent: 100)
    }
    
    func testCounterClockwiseCalculationsAcrossZero() {
        let sut = makeSUT(start: 340, end: 40, direction: .counterClockwise)
        expect(sut: sut, degrees: 340, forPercent: 0)
        expect(sut: sut, degrees: 265, forPercent: 25)
        expect(sut: sut, degrees: 190, forPercent: 50)
        expect(sut: sut, degrees: 115, forPercent: 75)
        expect(sut: sut, degrees: 40, forPercent: 100)
    }
    
    private func expect(sut: DegreesCalculator, degrees: CGFloat, forPercent percent: CGFloat) {
        XCTAssertEqual(sut.degreesForPercent(percent), degrees, accuracy: 0.01)
    }
    
    private func makeSUT(start: CGFloat, end: CGFloat, direction: RotationDirection) -> DegreesCalculator {
        .init(startDegrees: start, endDegrees: end, direction: direction)
    }
}
