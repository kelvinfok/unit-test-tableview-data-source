//
//  tableviewTests.swift
//  tableviewTests
//
//  Created by Kelvin Fok on 30/1/23.
//

import XCTest
@testable import tableview

final class tableviewTests: XCTestCase {
  
  private var sut: DataSource!
  
  override func setUp()  {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
  }
  
  func testCellsHeight() {
    // given
    let feed: Feed = .default
    // when
    let sut = DataSource(feed: feed)
    // then
    let heightAtIndex0 = sut.tableView(.init(), heightForRowAt: .init(row: 0, section: 0))
    XCTAssertEqual(heightAtIndex0, 56)
    
    let heightAtIndex1 = sut.tableView(.init(), heightForRowAt: .init(row: 1, section: 0))
    XCTAssertEqual(heightAtIndex1, 201)
    
    let heightAtIndex2 = sut.tableView(.init(), heightForRowAt: .init(row: 2, section: 0))
    XCTAssertEqual(heightAtIndex2, 56)
  }
  
  func testCellTypes() {
    // given
    let feed: Feed = .default
    let tableView = UITableView()
    tableView.register(QuoteCell.self, forCellReuseIdentifier: "cellId")
    tableView.register(AdvertCell.self, forCellReuseIdentifier: "adCellId")
    // when
    let sut = DataSource(feed: feed)
    // then
    
    
    let cellAtIndex0: UITableViewCell = sut.tableView(tableView, cellForRowAt: .init(row: 0, section: 0))
    XCTAssertTrue(cellAtIndex0 is QuoteCell)
    
    let cellAtIndex1: UITableViewCell = sut.tableView(tableView, cellForRowAt: .init(row: 1, section: 0))
    XCTAssertTrue(cellAtIndex1 is AdvertCell)
    
    let cellAtIndex2: UITableViewCell = sut.tableView(tableView, cellForRowAt: .init(row: 2, section: 0))
    XCTAssertTrue(cellAtIndex2 is QuoteCell)
  }
  
  
}
