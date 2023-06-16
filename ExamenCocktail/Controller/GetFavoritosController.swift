//
//  GetFavoritosController.swift
//  ExamenCocktail
//
//  Created by MacBookMBA4 on 16/06/23.
//

import UIKit

class GetFavoritosController: UIViewController {
    
    
    @IBOutlet weak var btnBuscarOutlet: UIButton!
    
    
    @IBOutlet weak var txtBuscar: UITextField!
    
    
    @IBOutlet weak var collectionViewFavoritos: UICollectionView!
    
    
    
    
    
    
    
    
    
    var cocteles  : [Int] = []
    var IdCoctel : Int = 0
    var color = UIColor.red.cgColor
    var color2 = UIColor.white.cgColor
    var nombreCoctel : String? = "a"
    var categoria : [Drinks] = []
    var stCategory : String = "Cocktail"
    var dbManager = DBManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        dbManager.Get()
        collectionViewFavoritos.delegate = self
        collectionViewFavoritos.dataSource = self
        collectionViewFavoritos.register(UINib(nibName: "DrinkCell", bundle: .main), forCellWithReuseIdentifier: "DrinkCell")

    }
    

    @IBAction func btnBuscar(_ sender: UIButton) {
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
      //  updateUI()
    }
    func updateUI(){
        self.categoria.removeAll()

        DrinkViewModel.GetByName(nombreCoctel: self.nombreCoctel!) { result, error in
                    DispatchQueue.main.async {
                        if result!.drinks != nil {
                            for objCategoria in result!.drinks!{
                                self.categoria.append(objCategoria)
                            }
                            self.collectionViewFavoritos.reloadData()
                        }
                    }
                }
            }
    

}


// MARK: CollectionViewDelegate,DataSource

extension GetFavoritosController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DrinkCell", for: indexPath) as! DrinkCell
               
        let imageURLString = categoria[indexPath.row].strDrinkThumb
        UIImage.loadImageFromURLFavoritos(imageURLString!) { (image) in
            if let image = image {
                // La imagen se cargó exitosamente desde la URL
                cell.imageView.image = image
            } else {
                print("error al cargar la imagen")
            }
        }
      
        
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
static func loadImageFromURLFavoritos(_ urlString: String, completion1: @escaping (UIImage?) -> Void) {
guard let url = URL(string: urlString) else {
completion1(nil)
return
}

URLSession.shared.dataTask(with: url) { (data, response, error) in
guard let data = data, let image = UIImage(data: data) else {
completion1(nil)
return
}

DispatchQueue.main.async {
completion1(image)
}
}.resume()
}
}
