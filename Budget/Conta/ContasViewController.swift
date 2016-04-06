//
//  ContasViewController.swift
//  Budget
//
//  Created by Yuri Pereira on 3/23/16.
//  Copyright © 2016 Budget. All rights reserved.
//

import UIKit
import CoreData

class ContasViewController: UITableViewController, TipoContasViewControllerDelegate, UITextFieldDelegate {
    
    
    var currentString = ""
    var erros: String = ""
    var conta: Conta?
    let contaDAO:ContaDAO = ContaDAO()
    var tipoConta: TipoConta?
    
    @IBOutlet var labels: [UILabel]!
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtSaldo: UITextField!
    @IBOutlet weak var txtTipo: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtSaldo.delegate = self
        
        if let conta = conta {
            txtNome.text = conta.nome!
            
            if let saldo = conta.saldo?.floatValue{
                txtSaldo.text = saldo.convertToMoedaBr()
            }
            
            tipoConta = conta.tipoconta // as? TipoConta
            
            txtSaldo.enabled = false
        }
        
        txtTipo.text = tipoConta?.nome
        
        FormCustomization.updateWidthsForLabels(labels)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func maskTextField(sender: UITextField) {
        FormCustomization.aplicarMascara(&sender.text!)
    }
    
    
    @IBAction func btnCancel(sender: AnyObject) {
        dissmissViewController()
    }
    
    
    @IBAction func btnSave(sender: AnyObject) {
        
        if conta != nil {
            updateConta()
            //navigationController?.popViewControllerAnimated(true)
        }else{
            addConta()
            //dissmissViewController()
        }
        
        
    }
    
    func dissmissViewController(){
        navigationController?.popViewControllerAnimated(true)
    }
    
    func validarCampos(){
        if Validador.vazio(txtNome.text!){
            erros.appendContentsOf("\nPreencha o campo nome!")
        }
        
        if Validador.vazio(txtSaldo.text!){
            erros.appendContentsOf("\nPreencha o campo Saldo!")
        }
        
        if Validador.vazio(txtTipo.text!){
            erros.appendContentsOf("\nSelecione a Conta!")
        }
    }
    
    func addConta(){
        
        validarCampos()
        
        if (erros.isEmpty == true){
            
            conta = Conta.getConta()
            conta?.nome = txtNome.text
            conta?.saldo = txtSaldo.text?.floatConverterMoeda()
            conta?.tipoconta = tipoConta
            
            salvarConta()
        }else{
            let alert = Notification.mostrarErro("Campos vazio", mensagem: "\(erros)")
            presentViewController(alert, animated: true, completion: nil)
            self.erros = ""
        }
    }
    
    func updateConta(){
        
        conta?.nome = txtNome.text
        conta?.saldo = txtSaldo.text!.floatConverterMoeda()
        
        if let tipoConta = tipoConta {
            conta?.tipoconta? = tipoConta
        }
        
        salvarConta()
    }
    
    private func salvarConta(){
        
        do{
            try contaDAO.salvar(conta!)
        }catch{
            let alert = Notification.mostrarErro("Desculpe", mensagem: "Não foi possível salvar")
            presentViewController(alert, animated: true, completion: nil)
        }
        
        dissmissViewController()
        
    }
    
    // Define Delegate Method
    func tipoContasViewControllerResponse(tipoConta: TipoConta) {
        self.tipoConta = tipoConta
        txtTipo.text = tipoConta.nome
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch(section) {
        case 0: return 2    // section 0 has 2 rows
        case 1: return 1    // section 1 has 1 row
        default: fatalError("Unknown number of sections")
        }
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        FormCustomization.dismissInputView([txtNome, txtSaldo])
        if segue.identifier == "alterarTipoConta"{
            let tipoContasController : TipoContasTableViewController = segue.destinationViewController as! TipoContasTableViewController
            tipoContasController.delegate = self
            tipoContasController.tela = true
        }
        
    }

}
/*====================================================================================

//                let currentCharacterCount = textField.text?.characters.count
//        print(range.length)

//        textField.text = TextoMascara.aplicarMascara(&textField.text!)
//        TextoMascara.aplicarMascara(&textField.text!)


====================================================================================*/