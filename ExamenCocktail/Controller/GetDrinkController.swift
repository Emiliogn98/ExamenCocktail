//
//  DrinkController.swift
//  ExamenCocktail
//
//  Created by MacBookMBA4 on 15/06/23.
//

import UIKit

class GetDrinkController: UIViewController {
    //Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var txtBuscar: UITextField!
    
    
    @IBOutlet weak var btnBuscarOutlet: UIButton!
    
    //Outlet
    var cocteles  : [Int] = []
    var IdCoctel : Int = 0
    var color = UIColor.red.cgColor
    var color2 = UIColor.white.cgColor
    var nombreCoctel : String? = "a"
    var categoria : [Drinks] = []
    var stCategory : String = "Cocktail"
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "DrinkCell", bundle: .main), forCellWithReuseIdentifier: "DrinkCell")
        
        
    }
    
    @IBAction func btnBuscar(_ sender: Any) {
        nombreCoctel = txtBuscar.text
               print(nombreCoctel)
               guard txtBuscar.text != "" else{
                          
                   txtBuscar.layer.borderColor = color
                   txtBuscar.layer.borderWidth = 1.0
                          return
                      }
               txtBuscar.layer.borderColor = color2
               txtBuscar.layer.borderWidth = 1.0
            updateUI()
       
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    func updateUI(){
        self.categoria.removeAll()
        //        DrinkViewModel.GetCategoria { result, error in
        //
        //            DispatchQueue.main.async {
        //                if result!.drinks != nil{
        //                    for objDrink in result!.drinks!{
        //                        self.categoria.append(objDrink)
        //                    }
        //                    self.collectionView.reloadData()
        //                }
        //               // print(self.categoria)
        //            }
        //
        //        }
        
//        DrinkViewModel.GetByCategoria(strCategory: self.stCategory) { result, error in
//            DispatchQueue.main.async {
//                if result!.drinks != nil {
//                    for objCategoria in result!.drinks!{
//                        self.categoria.append(objCategoria)
//                    }
//                    self.collectionView.reloadData()
//                }
//            }
//        }
//    }
        DrinkViewModel.GetByName(nombreCoctel: self.nombreCoctel!) { result, error in
                    DispatchQueue.main.async {
                        if result!.drinks != nil {
                            for objCategoria in result!.drinks!{
                                self.categoria.append(objCategoria)
                            }
                            self.collectionView.reloadData()
                        }
                    }
                }
            }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //controlar que hacer antes de ir a la siguiente vista
        
                        if segue.identifier == "DrinkDetailSegue" {
                            let formControl = segue.destination as! DrinkDetailController
                            formControl.IdCoctel = self.IdCoctel
        
                        }
        
        //                if segue.identifier == "BuscadorDetalleSegue"{
        //                    let formControl = segue.destination as! DatalleController
        //                    formControl.nombreCoctel = self.nombreCoctel!
        // formControl.IdCoctel = self.IdCoctel
        
        //                }
        
    }
}


// MARK: CollectionViewDelegate,DataSource

extension GetDrinkController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DrinkCell", for: indexPath) as! DrinkCell
               
        let imageURLString = categoria[indexPath.row].strDrinkThumb
        UIImage.loadImageFromURL(imageURLString!) { (image) in
        if let image = image {
        // La imagen se cargó exitosamente desde la URL
            cell.imageView.image = image
        } else {
            print("error al cargar la imagen")
        }
        }
                //cell.imageView.image = ""
        cell.lblNombre.text = categoria[indexPath.row].strDrink
        cell.lblCategoria.text = categoria[indexPath.row].strCategory
               // print(self.categoria)
         
     
         
         return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoria.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.IdCoctel = Int(self.categoria[indexPath.row].idDrink!)!
        self.performSegue(withIdentifier: "DrinkDetailSegue", sender: self)
        
    }
  
    
}

// MARK: UIImage

extension UIImage {
static func loadImageFromURL(_ urlString: String, completion: @escaping (UIImage?) -> Void) {
guard let url = URL(string: urlString) else {
completion(nil)
return
}

URLSession.shared.dataTask(with: url) { (data, response, error) in
guard let data = data, let image = UIImage(data: data) else {
completion(nil)
return
}

DispatchQueue.main.async {
completion(image)
}
}.resume()
}
}
