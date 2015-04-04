//<?php
/**
 * UnveilImages
 *
 * Light weight LazyLoad plugin
 *
 * @author    Nicola Lambathakis
 * @category    plugin
 * @version    1.0 PL
 * @license	 http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @internal    @events OnWebPagePrerender
 * @internal    @installset base
 * @internal    @modx_category Images
 * @internal    @properties  &TemplateImagesFolder= Template Images Folder:;string;assets/templates/templatename/images/ &LoadingImage= Loading Image:;string;assets/plugins/unveil/loading.gif
 */

/*
###UnveilImages Plugin for MODX Evolution###
Written By Nicola Lambathakis: http://www.tattoocms.it
Based on Unveil jQuery Plugin : https://github.com/luis-almeida/unveil
Version 1.0 PL
Events: OnWebPagePrerender

 */

/**
&TemplateImagesFolder= Template Images Folder:;string;assets/templates/templatename/images/ &LoadingImage= Loading Image:;string;assets/plugins/unveil/loading.gif

*/


$e= & $modx->Event;
switch ($e->name) {

case "OnWebPagePrerender" :
	$modx->documentOutput= str_replace('</head>', '<link href="assets/plugins/unveil/unveil.css" rel="stylesheet">
	</head>', $modx->documentOutput);


	$modx->documentOutput= str_replace('</body>', '<script src="assets/plugins/unveil/jquery.unveil.js"></script>
	<script src="assets/plugins/unveil/scripts.js"></script>
	</body>', $modx->documentOutput);


		// assets images (content)
	$modx->documentOutput= str_replace(' src="assets/images/',' src="'.$LoadingImage.'" data-src="assets/images/',$modx->documentOutput);
		// cache images (phpthumb)
	$modx->documentOutput= str_replace(' src="assets/cache/images/',' src="'.$LoadingImage.'" data-src="assets/cache/images/',$modx->documentOutput);
	// template images
	$modx->documentOutput= str_replace(' src="'.$TemplateImagesFolder.'',' src="'.$LoadingImage.'" data-src="'.$TemplateImagesFolder.'',$modx->documentOutput);

		break;

   default :
       return; // stop.
}