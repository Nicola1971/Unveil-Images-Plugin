//<?php
/**
 * UnveilImages
 *
 * Lightweight LazyLoad plugin
 *
 * @author    Nicola Lambathakis
 * @category    plugin
 * @version    1.0.1 PL
 * @license	 http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @internal    @events OnWebPagePrerender
 * @internal    @installset base
 * @internal    @modx_category Images
 * @internal    @properties  &LoadingImage= Loading Image:;string;assets/plugins/unveil/loading.gif &UnveilTemplateImages= UnveilTemplateImages:;list;yes,no;no &TemplateImagesFolder= Template Images Folder:;string;assets/templates/templatename/images/
 */

/*
###UnveilImages Plugin for MODX Evolution###
Written By Nicola Lambathakis: http://www.tattoocms.it
Based on Unveil jQuery Plugin : https://github.com/luis-almeida/unveil
Version 1.0.1 PL
Events: OnWebPagePrerender

 */

/**
&LoadingImage= Loading Image:;string;assets/plugins/unveil/loading.gif &UnveilTemplateImages= UnveilTemplateImages:;list;yes,no;no &TemplateImagesFolder= Template Images Folder:;string;assets/templates/templatename/images/

*/


$e= & $modx->Event;
switch ($e->name) {

case "OnWebPagePrerender" :
	$modx->documentOutput= str_replace('</body>', '<script src="assets/plugins/unveil/jquery.unveil.js"></script>
	<script src="assets/plugins/unveil/scripts.js"></script>
	</body>', $modx->documentOutput);


		// assets images (content)
	$modx->documentOutput= str_replace(' src="assets/images/',' src="'.$LoadingImage.'" data-src="assets/images/',$modx->documentOutput);

		// cache images (phpthumb)
	$modx->documentOutput= str_replace(' src="assets/cache/images/',' src="'.$LoadingImage.'" data-src="assets/cache/images/',$modx->documentOutput);


	// template images
	 if ($UnveilTemplateImages == yes) {
	$modx->documentOutput= str_replace(' src="'.$TemplateImagesFolder.'',' src="'.$LoadingImage.'" data-src="'.$TemplateImagesFolder.'',$modx->documentOutput);
 }
		break;

   default :
       return; // stop.
}