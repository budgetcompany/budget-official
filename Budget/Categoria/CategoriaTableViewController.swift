//
//  CategoriaTableViewController.swift
//  Budget
//
//  Created by md10 on 3/18/16.
//  Copyright © 2016 Budget. All rights reserved.
//

import UIKit
import CoreData

class CategoriaTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    let categoriaDAO:CategoriaDAO = CategoriaDAO()
    
    var delegate: CategoriaViewControllerDelegate?
    var tela:Bool = false
    var frc = Categoria.getCategoriasController("nome")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frc.delegate = self
        
        // Caso seja acessado diretamente, exibir o botão, se não o botão não é inserido. Isso deve acontecer porque há o botão voltar.
        if tela == false {
            let btnSidebar = UIBarButtonItem(image: UIImage(named: "interface.png"), style: .Done, target: self, action: nil)
            self.navigationItem.setLeftBarButtonItem(btnSidebar, animated: false)
            SidebarMenu.configMenu(self, sideBarMenu: btnSidebar)
        }
        
        do{
            try frc.performFetch()
        }catch{
            let alerta = Notification.mostrarErro()
            presentViewController(alerta, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        let numbersOfSections = frc.sections?.count
        return numbersOfSections!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberOfRowsInSection = frc.sections?[section].numberOfObjects
        return numberOfRowsInSection!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let categoria = frc.objectAtIndexPath(indexPath) as! Categoria
        delegate?.categoriaViewControllerResponse(categoria)
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellCategoria", forIndexPath: indexPath)
        
        let categoria = frc.objectAtIndexPath(indexPath) as! Categoria
        cell.textLabel?.text = categoria.nome
        
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {

        if (indexPath.row % 2 == 0){
            cell.backgroundColor = Color.uicolorFromHex(0xf9f9f9)
        }else{
            cell.backgroundColor = Color.uicolorFromHex(0xffffff)
        }
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let categoria = frc.objectAtIndexPath(indexPath) as! Categoria
            
            // Método para ser chamado ao deletar item
            func removerSelecionado(action:UIAlertAction){
                do{
                    try categoriaDAO.remover(categoria)
                }catch{
                    presentViewController(Notification.mostrarErro(), animated: true, completion: nil)
                }
            }
            
            // Verifica se tem alguma despesa associada
            if (categoria.despesa?.count > 0) {
                
                let alerta = Notification.mostrarErro("Desculpe", mensagem: "Você não pode deletar porque há uma ou mais despesas associadas.")
                presentViewController(alerta, animated: true, completion: nil)
            
            // Verifica se tem alguma receita associada
            } else if (categoria.receita?.count > 0) {
                
                let alerta = Notification.mostrarErro("Desculpe", mensagem: "Você não pode deletar porque há uma ou mais receitas associadas.")
                presentViewController(alerta, animated: true, completion: nil)
            
            // Se não tiver permite deletar
            } else {
                
                let detalhes = Notification.solicitarConfirmacao("Deletar", mensagem: "Tem certeza que deseja deletar?", completion:removerSelecionado)
                presentViewController(detalhes, animated: true, completion: nil)
                atualizarTableView()
            }
        }
    }
    
    // MARK: - Delegate methods
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        atualizarTableView()
    }
    
    // MARK: - Private functions
    
    private func atualizarTableView(){
        tableView.reloadData()
    }

}