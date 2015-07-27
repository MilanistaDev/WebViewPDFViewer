//
//  ViewController.m
//  WebViewPDFViewer
//
//  Created by Takuya Aso on 2015/07/21.
//  Copyright © 2015年 Takuya Aso. All rights reserved.
//

#import "ViewController.h"
@import CoreGraphics;       // 追加 for CGPDFDocument 系
#import "CheckNetWork.h"    // 追加 for NetWork Check

@interface ViewController () <UIWebViewDelegate>

// CGPDFDocument
@property (nonatomic) CGPDFDocumentRef document;

// WebView
@property (weak, nonatomic) IBOutlet UIWebView *pdfViewerWebView;
@property (nonatomic) UIScrollView *scrollView;

// ページナンバー系
@property (nonatomic) NSInteger numberOfPages;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPagesLabel;

@property (nonatomic) NSInteger pageNumber;

// ページコントロール系
@property (weak, nonatomic) IBOutlet UIButton *backButton;
- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
- (IBAction)goAction:(id)sender;

@end

#pragma mark - Life Cycle

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初回表示の設定
    [self firstSetUp];
}

#pragma mark - First Set Up

- (void)firstSetUp {
    
    // delegate を自分自身
    
    _pdfViewerWebView.delegate = self;
    
    // WebView にフィットさせる
    _pdfViewerWebView.scalesPageToFit = YES;
    
    // 直接URLにアクセスせずファイルをプロジェクトに入れるとき用
    /*
     NSString*   path;
     NSURL*      url;
     path = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"pdf"];
     url = [NSURL fileURLWithPath:path];
     _document = CGPDFDocumentCreateWithURL((CFURLRef)url);
     */
    
    // PDFのURL(via 厚生労働省)
    NSString *pdfURLStr = @"http://www.mhlw.go.jp/file/06-Seisakujouhou-12300000-Roukenkyoku/0000080254.pdf";
    NSURL *url = [NSURL URLWithString:pdfURLStr];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];

    
    // ネットワークがオンラインならリクエストを送る
    // やらないとオフライン時にアプリが落ちる
    BOOL check = [CheckNetWork checkNetWork];
    
    // オンライン
    if (check) {
        [_pdfViewerWebView loadRequest:req];
    } else {
        [self alertNetWorkError];
    }

    //[_pdfViewerWebView loadRequest:req];
    // ページナンバーを決めて表示
    _pageNumber = 1;
    _num.text = [NSString stringWithFormat:@"%ld", _pageNumber];
    
    // NSURL から PDFDocument 作成
    _document = CGPDFDocumentCreateWithURL((CFURLRef)url);
    
    // ページ数取得
    _numberOfPages= CGPDFDocumentGetNumberOfPages(_document);
    _numberOfPagesLabel.text = [NSString stringWithFormat:@"%ld", _numberOfPages];
    
}

/**
 *  戻るボタンを押下したとき
 */
- (IBAction)backAction:(id)sender {
    
    if (_pageNumber > 1) {
        
        // 1 つ分減らす
        _pageNumber = _pageNumber - 1;
        _num.text = [NSString stringWithFormat:@"%ld", _pageNumber];
        
        // UIWebView を 1 ページ分戻す(ScrollView が戻る)
        UIWebView *webView = _pdfViewerWebView;
        _scrollView = webView.scrollView;
        
        // 座標を決めてそこに移動する(y は見たらわかるはず)
        float x = _scrollView.contentOffset.x;
        float y = _scrollView.contentSize.height/_numberOfPages*(_pageNumber - 1);
        CGPoint point = CGPointMake(x, y);
        
        [_scrollView setContentOffset:point animated:YES];
        
    } else {
        
        // ボタン無効処理などを書く
    }
}

/**
 *  進むボタンを押下したとき
 */
- (IBAction)goAction:(id)sender {
    
    if (_pageNumber < _numberOfPages) {
        
        UIWebView *webView = _pdfViewerWebView;
        _scrollView = webView.scrollView;
        
        // 座標を決めてそこに移動する
        float x = _scrollView.contentOffset.x;
        float y = _scrollView.contentSize.height/_numberOfPages*_pageNumber;
        
        CGPoint point = CGPointMake(x, y);
        [_scrollView setContentOffset:point animated:YES];
        
        // 1 つ分増やす
        _pageNumber = _pageNumber + 1;
        _num.text = [NSString stringWithFormat:@"%ld", _pageNumber];
        
    } else {
        
        // ボタン無効処理などを書く
    }
}

#pragma mark - Alert

- (void)alertNetWorkError {
    
    UIAlertView *alert;
    
    // 現在の iOS のバージョンを取得
    float iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    // 異なる場合その旨をアラートで表示
    if(iOSVersion >= 8.0) {
        
        // コントローラを生成
        UIAlertController *alert_c = [UIAlertController alertControllerWithTitle:@"確認"
                                                                         message:@"ネットワークがオフラインです。"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
        // addAction (ボタン数)
        [alert_c addAction:[UIAlertAction actionWithTitle:@"OK"
                                                    style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction *action){
                                                  }]];
        // アラート表示処理
        [self presentViewController:alert_c animated:YES completion:nil];
        
    } else {
        // iOS 7
        alert.delegate = self;
        alert.title = @"確認";
        alert.message = @"ネットワークがオフラインです。";
        [alert addButtonWithTitle:@"OK"];
        [alert show];
    }
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
