//
//  Notification.swift
//  Budget
//
//  Created by Calebe Santos on 3/14/16.
//  Copyright © 2016 Budget. All rights reserved.
//

import UIKit

public class Notification {
    static func mostrarErro(titulo: String = "Desculpe", mensagem: String = "Erro inesperado") -> UIAlertController{
        
        let detalhes = UIAlertController(title: titulo, message: mensagem, preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelar = UIAlertAction(title: "Entendido", style: UIAlertActionStyle.Cancel, handler: nil)
        
        detalhes.addAction(cancelar)
        
        return detalhes
    }
    
    static func solicitarConfirmacao(titulo: String = "Desculpe", mensagem: String = "Erro inesperado", completion:(UIAlertAction) -> Void) -> UIAlertController {
        
        let detalhes = UIAlertController(title: titulo, message: mensagem, preferredStyle: UIAlertControllerStyle.Alert)
        let cancelar = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: nil)
        let deletar = UIAlertAction(title: "Deletar", style: UIAlertActionStyle.Destructive, handler: completion)
        
        detalhes.addAction(cancelar)
        detalhes.addAction(deletar)
        
        return detalhes
    }
    
    static func solicitarConfirmacaoDespesa(titulo: String = "Desculpe", mensagem: String = "Erro inesperado", completion:(UIAlertAction) -> Void) -> UIAlertController {
        
        let detalhes = UIAlertController(title: titulo, message: mensagem, preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelar = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: nil)
        let deletar = UIAlertAction(title: "Salvar", style: UIAlertActionStyle.Destructive, handler: completion)
        
        detalhes.addAction(cancelar)
        detalhes.addAction(deletar)
        
        return detalhes
    }
    
    static func avisoReceita(titulo: String = "Desculpe", mensagem: String = "Erro inesperado", completion:(UIAlertAction) -> Void) -> UIAlertController{
        
        let detalhes = UIAlertController(title: titulo, message: mensagem, preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelar = UIAlertAction(title: "Entendido", style: UIAlertActionStyle.Cancel, handler: completion)
        
        detalhes.addAction(cancelar)
        
        return detalhes
    }
}