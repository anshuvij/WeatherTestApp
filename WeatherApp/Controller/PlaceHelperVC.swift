//
//  PlaceHelperVC.swift
//  Weatherly
//
//  Created by Anshu Vij on 2/8/21.
//

import UIKit
import MapKit

protocol PlaceHelperDelegate {
    func selectedLocation(lat : Double?, lon : Double?, name : String?)
}

class PlaceHelperVC: UIViewController,UISearchBarDelegate, MKLocalSearchCompleterDelegate {
 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    var searchCompleter = MKLocalSearchCompleter()
       
       // These are the results that are returned from the searchCompleter & what we are displaying
       // on the searchResultsTable
       var searchResults = [MKLocalSearchCompletion]()
      var delegate : PlaceHelperDelegate?
    
    
    override func viewDidLoad() {
        searchCompleter.delegate = self
        searchBar?.delegate = self
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.endEditing(true)

        // Do any additional setup after loading the view.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchCompleter.queryFragment = searchText
        }
        
        // This method declares gets called whenever the searchCompleter has new search results
        // If you wanted to do any filter of the locations that are displayed on the the table view
        // this would be the place to do it.
        func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
            
            // Setting our searcResults variable to the results that the searchCompleter returned
            searchResults = completer.results
            
            // Reload the tableview with our new searchResults
            tableView.reloadData()
        }
        
        // This method is called when there was an error with the searchCompleter
        func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
            // Error
        }

}

extension PlaceHelperVC: UITableViewDataSource {
    // This method declares the number of sections that we want in our table.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // This method declares how many rows are the in the table
    // We want this to be the number of current search results that the
    // Completer has generated for us
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    // This method delcares the cells that are table is going to show at a particular index
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the specific searchResult at the particular index
        let searchResult = searchResults[indexPath.row]
        
        //Create  a new UITableViewCell object
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        //Set the content of the cell to our searchResult data
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        return cell
    }
}

extension PlaceHelperVC: UITableViewDelegate {
    // This method declares the behavior of what is to happen when the row is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let result = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: result)
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { [self] (response, error) in
            guard let coordinate = response?.mapItems[0].placemark.coordinate else {
                return
            }
            
            guard let name = response?.mapItems[0].name else {
                return
            }
            
            let lat = coordinate.latitude
            let lon = coordinate.longitude
        
            dismiss(animated: true, completion: nil)
            delegate?.selectedLocation(lat: lat, lon: lon, name: name)
            
        }
    }
}
