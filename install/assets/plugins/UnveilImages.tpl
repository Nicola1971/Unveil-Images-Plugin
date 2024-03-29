//<?php
/**
 * UnveilImages
 *
 * Lightweight LazyLoad plugin
 *
 * @author    Nicola Lambathakis
 * @category    plugin
 * @version    1.2 PL
 * @license	 http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @internal    @events OnWebPagePrerender,OnLoadWebDocument
 * @internal    @installset base
 * @internal    @modx_category Images
 * @internal    @properties  &LoadingImage= Loading Image:;string;assets/plugins/unveil/loading.gif &UnveilConfig= Unveil js Config:;string;assets/plugins/unveil/unveilconfig.js &ImagesFolder= Images Folder:;string;assets/images/ &UnveilGalleryImages= Unveil Gallery Images:;list;yes,no;no &GalleryImagesFolder= Gallery Images Folder:;string;assets/galleries/ &UnveilTemplateImages= Unveil Template Images:;list;yes,no;no &TemplateImagesFolder= Template Images Folder:;string;assets/templates/templatename/images/ &UnveilCustumImages= Unveil Custom Images:;list;yes,no;no &UnveilCustumFolder= Custom Images Folder:;string;assets/yourfolder &ResponsiveClass= Responsive Class:;string;img-responsive &exclude_docs=Comma-separated IDs of documents to except;string; 
 */
/*
###UnveilImages Plugin for Evolution cms###
Written By Nicola Lambathakis: http://www.tattoocms.it
Based on Unveil jQuery Plugin : https://github.com/luis-almeida/unveil
Version 1.2
Events: OnWebPagePrerender,OnLoadWebDocument
*/


/**
&LoadingImage= Loading Image:;string;assets/plugins/unveil/loading.gif &UnveilConfig= Unveil js Config:;string;assets/plugins/unveil/unveilconfig.js &ImagesFolder= Images Folder:;string;assets/images/ &UnveilGalleryImages= Unveil Gallery Images:;list;yes,no;no &GalleryImagesFolder= Gallery Images Folder:;string;assets/galleries/ &UnveilTemplateImages= Unveil Template Images:;list;yes,no;no &TemplateImagesFolder= Template Images Folder:;string;assets/templates/templatename/images/ &UnveilCustumImages= Unveil Custom Images:;list;yes,no;no &UnveilCustumFolder= Custom Images Folder:;string;assets/yourfolder &ResponsiveClass= Responsive Class:;string;img-responsive &exclude_docs=Comma-separated IDs of documents to except;string; 
*/

$exclude_docs = isset($exclude_docs) ? $exclude_docs : '';
$e= & $modx->Event;
$document_id = $modx -> documentObject['id'];

			
switch ($e->name) {
case "OnLoadWebDocument":
if ($document_id != $exclude_docs) {	
	// assets images (content)
	$modx->documentObject['content'] = str_replace(' src="'.$ImagesFolder.'',' src="'.$LoadingImage.'" class="'.$ResponsiveClass.'" data-src="'.$ImagesFolder.'',$modx->documentObject['content']);
}
case "OnWebPagePrerender" :
if ($document_id != $exclude_docs) {	
	$modx->documentOutput= str_replace('</body>', '<script src="assets/plugins/unveil/jquery.unveil.js"></script>
	<script src="'.$UnveilConfig.'"></script></body>', $modx->documentOutput);
	
		// cache images (phpthumb)
	$modx->documentOutput= str_replace(' src="assets/cache/images/',' src="'.$LoadingImage.'" class="'.$ResponsiveClass.'" data-src="assets/cache/images/',$modx->documentOutput);

		// gallery images
	 if ($UnveilGalleryImages == 'yes') {
	$modx->documentOutput= str_replace(' src="'.$GalleryImagesFolder.'',' src="'.$LoadingImage.'" class="'.$ResponsiveClass.'" data-src="'.$GalleryImagesFolder.'',$modx->documentOutput);
 }

	// template images
	 if ($UnveilTemplateImages == 'yes') {
	$modx->documentOutput= str_replace(' src="'.$TemplateImagesFolder.'',' src="'.$LoadingImage.'" class="'.$ResponsiveClass.'" data-src="'.$TemplateImagesFolder.'',$modx->documentOutput);
 }
		// custom folder images
	 if ($UnveilCustumImages == 'yes') {
	$modx->documentOutput= str_replace(' src="'.$UnveilCustumFolder.'',' src="'.$LoadingImage.'" class="'.$ResponsiveClass.'" data-src="'.$UnveilCustumFolder.'',$modx->documentOutput);
	}
}	

		break;

   default :
       return; // stop.

}