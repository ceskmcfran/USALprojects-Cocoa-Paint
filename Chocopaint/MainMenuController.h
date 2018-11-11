//
//  MainMenuController.h
//  Chocopaint
//
//  Created by Alumno on 12/12/16.
//  Copyright © 2016 Francisco Blázquez. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class ETPanelController;

@interface MainMenuController : NSObject <NSWindowDelegate>{

    ETPanelController * panel;
    
    NSMutableArray * arrayFiguras; //Modelo
    
}

- (id)init; //Init
- (IBAction) showPanel:(id)sender; //Muestra la ventana
- (void) handlePanelDibuja:(NSNotification *)aNotificacion; //Handler para dibujar
- (BOOL) windowShouldClose:(id)sender; //Termina la app
- (void) dibujarFigurasWithGraphicContext:(NSGraphicsContext *)ctx;

@end
