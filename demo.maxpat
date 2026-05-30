{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 9,
			"minor" : 0,
			"revision" : 8,
			"architecture" : "x64",
			"modernui" : 1
		}
,
		"classnamespace" : "box",
		"rect" : [ 61.0, 134.0, 1025.0, 841.0 ],
		"gridsize" : [ 15.0, 15.0 ],
		"boxes" : [ 			{
				"box" : 				{
					"id" : "obj-17",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 863.0, 211.0, 143.0, 22.0 ],
					"text" : "connect encoder mc 0 32"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-55",
					"maxclass" : "multislider",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 132.0, 510.0, 356.0, 40.0 ],
					"saved_attribute_attributes" : 					{
						"slidercolor" : 						{
							"expression" : "themecolor.live_lcd_control_fg"
						}

					}
,
					"setminmax" : [ -4.0, 4.0 ],
					"size" : 32,
					"slidercolor" : [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
					"thickness" : 1
				}

			}
, 			{
				"box" : 				{
					"hidden" : 1,
					"id" : "obj-81",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 368.0, 723.0, 68.0, 22.0 ],
					"text" : "zl.group 32"
				}

			}
, 			{
				"box" : 				{
					"hidden" : 1,
					"id" : "obj-78",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 368.0, 690.0, 164.0, 22.0 ],
					"text" : "mc.snapshot~ 23 @chans 32"
				}

			}
, 			{
				"box" : 				{
					"hidden" : 1,
					"id" : "obj-76",
					"maxclass" : "newobj",
					"numinlets" : 32,
					"numoutlets" : 1,
					"outlettype" : [ "multichannelsignal" ],
					"patching_rect" : [ 368.0, 657.0, 344.5, 22.0 ],
					"text" : "mc.pack~ 32",
					"varname" : "mc"
				}

			}
, 			{
				"box" : 				{
					"bubble" : 1,
					"bubblepoint" : 0.23,
					"fontname" : "Lato",
					"fontsize" : 12.0,
					"id" : "obj-26",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 773.0, 148.0, 299.0, 39.0 ],
					"text" : "Disconnect patch cords 32 (include) to 64 (exclude), from \"encoder\" to \"decoder\"."
				}

			}
, 			{
				"box" : 				{
					"bubble" : 1,
					"bubblepoint" : 0.3,
					"fontname" : "Lato",
					"fontsize" : 12.0,
					"id" : "obj-24",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 744.0, 84.0, 293.0, 39.0 ],
					"text" : "Connect patch cords 0 (include) to 256 (exclude), from \"encoder\" to \"decoder\"."
				}

			}
, 			{
				"box" : 				{
					"fontface" : 0,
					"fontname" : "Lato Medium",
					"fontsize" : 13.0,
					"id" : "obj-21",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 556.0, 27.0, 308.0, 22.0 ],
					"saved_attribute_attributes" : 					{
						"textcolor" : 						{
							"expression" : "themecolor.live_control_fg"
						}

					}
,
					"text" : "Message arguments:"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-16",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 556.0, 51.0, 413.0, 20.0 ],
					"text" : "connect [src-varname] [dst-varname] [cord-idx-start] [cord-idx-end]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-14",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 556.0, 215.0, 251.0, 47.0 ],
					"text" : "To use this, make sure to set the `varname` attribute of both nn~ objects to 'encoder' and 'decoder' "
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-11",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 574.0, 132.0, 193.0, 22.0 ],
					"text" : "disconnect encoder decoder 32 64"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-12",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 556.0, 84.0, 177.0, 22.0 ],
					"text" : "connect encoder decoder 0 256"
				}

			}
, 			{
				"box" : 				{
					"filename" : "connection.js",
					"id" : "obj-10",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 556.0, 165.0, 145.0, 22.0 ],
					"saved_object_attributes" : 					{
						"parameter_enable" : 0
					}
,
					"text" : "v8 connection @embed 1",
					"textfile" : 					{
						"filename" : "connection.js",
						"flags" : 1,
						"embed" : 0,
						"autowatch" : 1
					}

				}

			}
, 			{
				"box" : 				{
					"id" : "obj-6",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 256,
					"outlettype" : [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal" ],
					"patching_rect" : [ 132.0, 480.0, 2696.5, 22.0 ],
					"text" : "nn~ same_s_mps encode 8192",
					"varname" : "encoder"
				}

			}
, 			{
				"box" : 				{
					"basictuning" : 440,
					"clipheight" : 27.5,
					"color" : [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
					"data" : 					{
						"clips" : [ 							{
								"absolutepath" : "brushes.aif",
								"filename" : "brushes.aif",
								"filekind" : "audiofile",
								"id" : "u398009537",
								"loop" : 1,
								"content_state" : 								{
									"loop" : 1
								}

							}
, 							{
								"absolutepath" : "cello-f2.aif",
								"filename" : "cello-f2.aif",
								"filekind" : "audiofile",
								"id" : "u947000838",
								"loop" : 1,
								"content_state" : 								{
									"loop" : 1
								}

							}
 ]
					}
,
					"followglobaltempo" : 0,
					"formantcorrection" : 0,
					"id" : "obj-4",
					"maxclass" : "playlist~",
					"mode" : "basic",
					"numinlets" : 1,
					"numoutlets" : 5,
					"originallength" : [ 0.0, "ticks" ],
					"originaltempo" : 120.0,
					"outlettype" : [ "signal", "signal", "signal", "", "dictionary" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 227.0, 392.0, 194.0, 55.0 ],
					"pitchcorrection" : 0,
					"quality" : "basic",
					"saved_attribute_attributes" : 					{
						"candicane2" : 						{
							"expression" : ""
						}
,
						"candicane3" : 						{
							"expression" : ""
						}
,
						"candicane4" : 						{
							"expression" : ""
						}
,
						"candicane5" : 						{
							"expression" : ""
						}
,
						"candicane6" : 						{
							"expression" : ""
						}
,
						"candicane7" : 						{
							"expression" : ""
						}
,
						"candicane8" : 						{
							"expression" : ""
						}
,
						"color" : 						{
							"expression" : "themecolor.live_lcd_control_fg"
						}

					}
,
					"timestretch" : [ 0 ]
				}

			}
, 			{
				"box" : 				{
					"color" : [ 0.931948395395052, 0.771744459193783, 0.523883756405412, 1.0 ],
					"id" : "obj-8",
					"local" : 1,
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 132.0, 608.0, 45.0, 45.0 ],
					"saved_attribute_attributes" : 					{
						"color" : 						{
							"expression" : "themecolor.live_lcd_control_fg"
						}

					}

				}

			}
, 			{
				"box" : 				{
					"attr" : "gpu",
					"id" : "obj-5",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 51.0, 425.0, 150.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"attr" : "enable_model",
					"id" : "obj-3",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 51.0, 401.0, 150.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-1",
					"maxclass" : "newobj",
					"numinlets" : 256,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "signal" ],
					"patching_rect" : [ 132.0, 558.0, 2696.5, 22.0 ],
					"text" : "nn~ same_s_mps decode 8192",
					"varname" : "decoder"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-8", 1 ],
					"source" : [ "obj-1", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-8", 0 ],
					"source" : [ "obj-1", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-10", 0 ],
					"source" : [ "obj-11", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-10", 0 ],
					"source" : [ "obj-12", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-10", 0 ],
					"source" : [ "obj-17", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 0 ],
					"order" : 0,
					"source" : [ "obj-3", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-6", 0 ],
					"order" : 1,
					"source" : [ "obj-3", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-6", 1 ],
					"midpoints" : [ 280.25, 465.0, 2819.0, 465.0 ],
					"source" : [ "obj-4", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-6", 0 ],
					"midpoints" : [ 236.5, 465.0, 141.5, 465.0 ],
					"source" : [ "obj-4", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 0 ],
					"order" : 0,
					"source" : [ "obj-5", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-6", 0 ],
					"order" : 1,
					"source" : [ "obj-5", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 255 ],
					"source" : [ "obj-6", 255 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 254 ],
					"source" : [ "obj-6", 254 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 253 ],
					"source" : [ "obj-6", 253 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 252 ],
					"source" : [ "obj-6", 252 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 251 ],
					"source" : [ "obj-6", 251 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 250 ],
					"source" : [ "obj-6", 250 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 249 ],
					"source" : [ "obj-6", 249 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 248 ],
					"source" : [ "obj-6", 248 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 247 ],
					"source" : [ "obj-6", 247 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 246 ],
					"source" : [ "obj-6", 246 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 245 ],
					"source" : [ "obj-6", 245 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 244 ],
					"source" : [ "obj-6", 244 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 243 ],
					"source" : [ "obj-6", 243 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 242 ],
					"source" : [ "obj-6", 242 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 241 ],
					"source" : [ "obj-6", 241 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 240 ],
					"source" : [ "obj-6", 240 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 239 ],
					"source" : [ "obj-6", 239 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 238 ],
					"source" : [ "obj-6", 238 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 237 ],
					"source" : [ "obj-6", 237 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 236 ],
					"source" : [ "obj-6", 236 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 235 ],
					"source" : [ "obj-6", 235 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 234 ],
					"source" : [ "obj-6", 234 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 233 ],
					"source" : [ "obj-6", 233 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 232 ],
					"source" : [ "obj-6", 232 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 231 ],
					"source" : [ "obj-6", 231 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 230 ],
					"source" : [ "obj-6", 230 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 229 ],
					"source" : [ "obj-6", 229 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 228 ],
					"source" : [ "obj-6", 228 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 227 ],
					"source" : [ "obj-6", 227 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 226 ],
					"source" : [ "obj-6", 226 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 225 ],
					"source" : [ "obj-6", 225 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 224 ],
					"source" : [ "obj-6", 224 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 223 ],
					"source" : [ "obj-6", 223 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 222 ],
					"source" : [ "obj-6", 222 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 221 ],
					"source" : [ "obj-6", 221 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 220 ],
					"source" : [ "obj-6", 220 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 219 ],
					"source" : [ "obj-6", 219 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 218 ],
					"source" : [ "obj-6", 218 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 217 ],
					"source" : [ "obj-6", 217 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 216 ],
					"source" : [ "obj-6", 216 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 215 ],
					"source" : [ "obj-6", 215 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 214 ],
					"source" : [ "obj-6", 214 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 213 ],
					"source" : [ "obj-6", 213 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 212 ],
					"source" : [ "obj-6", 212 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 211 ],
					"source" : [ "obj-6", 211 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 210 ],
					"source" : [ "obj-6", 210 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 209 ],
					"source" : [ "obj-6", 209 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 208 ],
					"source" : [ "obj-6", 208 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 207 ],
					"source" : [ "obj-6", 207 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 206 ],
					"source" : [ "obj-6", 206 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 205 ],
					"source" : [ "obj-6", 205 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 204 ],
					"source" : [ "obj-6", 204 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 203 ],
					"source" : [ "obj-6", 203 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 202 ],
					"source" : [ "obj-6", 202 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 201 ],
					"source" : [ "obj-6", 201 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 200 ],
					"source" : [ "obj-6", 200 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 199 ],
					"source" : [ "obj-6", 199 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 198 ],
					"source" : [ "obj-6", 198 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 197 ],
					"source" : [ "obj-6", 197 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 196 ],
					"source" : [ "obj-6", 196 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 195 ],
					"source" : [ "obj-6", 195 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 194 ],
					"source" : [ "obj-6", 194 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 193 ],
					"source" : [ "obj-6", 193 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 192 ],
					"source" : [ "obj-6", 192 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 191 ],
					"source" : [ "obj-6", 191 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 190 ],
					"source" : [ "obj-6", 190 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 189 ],
					"source" : [ "obj-6", 189 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 188 ],
					"source" : [ "obj-6", 188 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 187 ],
					"source" : [ "obj-6", 187 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 186 ],
					"source" : [ "obj-6", 186 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 185 ],
					"source" : [ "obj-6", 185 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 184 ],
					"source" : [ "obj-6", 184 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 183 ],
					"source" : [ "obj-6", 183 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 182 ],
					"source" : [ "obj-6", 182 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 181 ],
					"source" : [ "obj-6", 181 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 180 ],
					"source" : [ "obj-6", 180 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 179 ],
					"source" : [ "obj-6", 179 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 178 ],
					"source" : [ "obj-6", 178 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 177 ],
					"source" : [ "obj-6", 177 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 176 ],
					"source" : [ "obj-6", 176 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 175 ],
					"source" : [ "obj-6", 175 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 174 ],
					"source" : [ "obj-6", 174 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 173 ],
					"source" : [ "obj-6", 173 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 172 ],
					"source" : [ "obj-6", 172 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 171 ],
					"source" : [ "obj-6", 171 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 170 ],
					"source" : [ "obj-6", 170 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 169 ],
					"source" : [ "obj-6", 169 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 168 ],
					"source" : [ "obj-6", 168 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 167 ],
					"source" : [ "obj-6", 167 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 166 ],
					"source" : [ "obj-6", 166 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 165 ],
					"source" : [ "obj-6", 165 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 164 ],
					"source" : [ "obj-6", 164 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 163 ],
					"source" : [ "obj-6", 163 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 162 ],
					"source" : [ "obj-6", 162 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 161 ],
					"source" : [ "obj-6", 161 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 160 ],
					"source" : [ "obj-6", 160 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 159 ],
					"source" : [ "obj-6", 159 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 158 ],
					"source" : [ "obj-6", 158 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 157 ],
					"source" : [ "obj-6", 157 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 156 ],
					"source" : [ "obj-6", 156 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 155 ],
					"source" : [ "obj-6", 155 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 154 ],
					"source" : [ "obj-6", 154 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 153 ],
					"source" : [ "obj-6", 153 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 152 ],
					"source" : [ "obj-6", 152 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 151 ],
					"source" : [ "obj-6", 151 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 150 ],
					"source" : [ "obj-6", 150 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 149 ],
					"source" : [ "obj-6", 149 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 148 ],
					"source" : [ "obj-6", 148 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 147 ],
					"source" : [ "obj-6", 147 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 146 ],
					"source" : [ "obj-6", 146 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 145 ],
					"source" : [ "obj-6", 145 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 144 ],
					"source" : [ "obj-6", 144 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 143 ],
					"source" : [ "obj-6", 143 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 142 ],
					"source" : [ "obj-6", 142 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 141 ],
					"source" : [ "obj-6", 141 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 140 ],
					"source" : [ "obj-6", 140 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 139 ],
					"source" : [ "obj-6", 139 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 138 ],
					"source" : [ "obj-6", 138 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 137 ],
					"source" : [ "obj-6", 137 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 136 ],
					"source" : [ "obj-6", 136 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 135 ],
					"source" : [ "obj-6", 135 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 134 ],
					"source" : [ "obj-6", 134 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 133 ],
					"source" : [ "obj-6", 133 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 132 ],
					"source" : [ "obj-6", 132 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 131 ],
					"source" : [ "obj-6", 131 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 130 ],
					"source" : [ "obj-6", 130 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 129 ],
					"source" : [ "obj-6", 129 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 128 ],
					"source" : [ "obj-6", 128 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 127 ],
					"source" : [ "obj-6", 127 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 126 ],
					"source" : [ "obj-6", 126 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 125 ],
					"source" : [ "obj-6", 125 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 124 ],
					"source" : [ "obj-6", 124 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 123 ],
					"source" : [ "obj-6", 123 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 122 ],
					"source" : [ "obj-6", 122 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 121 ],
					"source" : [ "obj-6", 121 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 120 ],
					"source" : [ "obj-6", 120 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 119 ],
					"source" : [ "obj-6", 119 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 118 ],
					"source" : [ "obj-6", 118 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 117 ],
					"source" : [ "obj-6", 117 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 116 ],
					"source" : [ "obj-6", 116 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 115 ],
					"source" : [ "obj-6", 115 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 114 ],
					"source" : [ "obj-6", 114 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 113 ],
					"source" : [ "obj-6", 113 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 112 ],
					"source" : [ "obj-6", 112 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 111 ],
					"source" : [ "obj-6", 111 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 110 ],
					"source" : [ "obj-6", 110 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 109 ],
					"source" : [ "obj-6", 109 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 108 ],
					"source" : [ "obj-6", 108 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 107 ],
					"source" : [ "obj-6", 107 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 106 ],
					"source" : [ "obj-6", 106 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 105 ],
					"source" : [ "obj-6", 105 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 104 ],
					"source" : [ "obj-6", 104 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 103 ],
					"source" : [ "obj-6", 103 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 102 ],
					"source" : [ "obj-6", 102 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 101 ],
					"source" : [ "obj-6", 101 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 100 ],
					"source" : [ "obj-6", 100 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 99 ],
					"source" : [ "obj-6", 99 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 98 ],
					"source" : [ "obj-6", 98 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 97 ],
					"source" : [ "obj-6", 97 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 96 ],
					"source" : [ "obj-6", 96 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 95 ],
					"source" : [ "obj-6", 95 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 94 ],
					"source" : [ "obj-6", 94 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 93 ],
					"source" : [ "obj-6", 93 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 92 ],
					"source" : [ "obj-6", 92 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 91 ],
					"source" : [ "obj-6", 91 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 90 ],
					"source" : [ "obj-6", 90 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 89 ],
					"source" : [ "obj-6", 89 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 88 ],
					"source" : [ "obj-6", 88 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 87 ],
					"source" : [ "obj-6", 87 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 86 ],
					"source" : [ "obj-6", 86 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 85 ],
					"source" : [ "obj-6", 85 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 84 ],
					"source" : [ "obj-6", 84 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 83 ],
					"source" : [ "obj-6", 83 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 82 ],
					"source" : [ "obj-6", 82 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 81 ],
					"source" : [ "obj-6", 81 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 80 ],
					"source" : [ "obj-6", 80 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 79 ],
					"source" : [ "obj-6", 79 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 78 ],
					"source" : [ "obj-6", 78 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 77 ],
					"source" : [ "obj-6", 77 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 76 ],
					"source" : [ "obj-6", 76 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 75 ],
					"source" : [ "obj-6", 75 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 74 ],
					"source" : [ "obj-6", 74 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 73 ],
					"source" : [ "obj-6", 73 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 72 ],
					"source" : [ "obj-6", 72 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 71 ],
					"source" : [ "obj-6", 71 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 70 ],
					"source" : [ "obj-6", 70 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 69 ],
					"source" : [ "obj-6", 69 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 68 ],
					"source" : [ "obj-6", 68 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 67 ],
					"source" : [ "obj-6", 67 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 66 ],
					"source" : [ "obj-6", 66 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 65 ],
					"source" : [ "obj-6", 65 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 64 ],
					"source" : [ "obj-6", 64 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 63 ],
					"source" : [ "obj-6", 63 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 62 ],
					"source" : [ "obj-6", 62 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 61 ],
					"source" : [ "obj-6", 61 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 60 ],
					"source" : [ "obj-6", 60 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 59 ],
					"source" : [ "obj-6", 59 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 58 ],
					"source" : [ "obj-6", 58 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 57 ],
					"source" : [ "obj-6", 57 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 56 ],
					"source" : [ "obj-6", 56 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 55 ],
					"source" : [ "obj-6", 55 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 54 ],
					"source" : [ "obj-6", 54 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 53 ],
					"source" : [ "obj-6", 53 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 52 ],
					"source" : [ "obj-6", 52 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 51 ],
					"source" : [ "obj-6", 51 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 50 ],
					"source" : [ "obj-6", 50 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 49 ],
					"source" : [ "obj-6", 49 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 48 ],
					"source" : [ "obj-6", 48 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 47 ],
					"source" : [ "obj-6", 47 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 46 ],
					"source" : [ "obj-6", 46 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 45 ],
					"source" : [ "obj-6", 45 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 44 ],
					"source" : [ "obj-6", 44 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 43 ],
					"source" : [ "obj-6", 43 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 42 ],
					"source" : [ "obj-6", 42 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 41 ],
					"source" : [ "obj-6", 41 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 40 ],
					"source" : [ "obj-6", 40 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 39 ],
					"source" : [ "obj-6", 39 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 38 ],
					"source" : [ "obj-6", 38 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 37 ],
					"source" : [ "obj-6", 37 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 36 ],
					"source" : [ "obj-6", 36 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 35 ],
					"source" : [ "obj-6", 35 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 34 ],
					"source" : [ "obj-6", 34 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 33 ],
					"source" : [ "obj-6", 33 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 32 ],
					"source" : [ "obj-6", 32 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 31 ],
					"order" : 1,
					"source" : [ "obj-6", 31 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 30 ],
					"order" : 1,
					"source" : [ "obj-6", 30 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 29 ],
					"order" : 1,
					"source" : [ "obj-6", 29 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 28 ],
					"order" : 1,
					"source" : [ "obj-6", 28 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 27 ],
					"order" : 1,
					"source" : [ "obj-6", 27 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 26 ],
					"order" : 1,
					"source" : [ "obj-6", 26 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 25 ],
					"order" : 1,
					"source" : [ "obj-6", 25 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 24 ],
					"order" : 1,
					"source" : [ "obj-6", 24 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 23 ],
					"order" : 1,
					"source" : [ "obj-6", 23 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 22 ],
					"order" : 1,
					"source" : [ "obj-6", 22 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 21 ],
					"order" : 1,
					"source" : [ "obj-6", 21 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 20 ],
					"order" : 1,
					"source" : [ "obj-6", 20 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 19 ],
					"order" : 1,
					"source" : [ "obj-6", 19 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 18 ],
					"order" : 1,
					"source" : [ "obj-6", 18 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 17 ],
					"order" : 1,
					"source" : [ "obj-6", 17 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 16 ],
					"order" : 1,
					"source" : [ "obj-6", 16 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 15 ],
					"order" : 1,
					"source" : [ "obj-6", 15 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 14 ],
					"order" : 1,
					"source" : [ "obj-6", 14 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 13 ],
					"order" : 1,
					"source" : [ "obj-6", 13 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 12 ],
					"order" : 1,
					"source" : [ "obj-6", 12 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 11 ],
					"order" : 1,
					"source" : [ "obj-6", 11 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 10 ],
					"order" : 1,
					"source" : [ "obj-6", 10 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 9 ],
					"order" : 1,
					"source" : [ "obj-6", 9 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 8 ],
					"order" : 1,
					"source" : [ "obj-6", 8 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 7 ],
					"order" : 1,
					"source" : [ "obj-6", 7 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 6 ],
					"order" : 1,
					"source" : [ "obj-6", 6 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 5 ],
					"order" : 1,
					"source" : [ "obj-6", 5 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 4 ],
					"order" : 1,
					"source" : [ "obj-6", 4 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 3 ],
					"order" : 1,
					"source" : [ "obj-6", 3 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 2 ],
					"order" : 1,
					"source" : [ "obj-6", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 1 ],
					"order" : 1,
					"source" : [ "obj-6", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 0 ],
					"order" : 1,
					"source" : [ "obj-6", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 31 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 31 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 30 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 30 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 29 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 29 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 28 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 28 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 27 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 27 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 26 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 26 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 25 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 25 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 24 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 24 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 23 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 23 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 22 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 22 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 21 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 21 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 20 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 20 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 19 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 19 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 18 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 18 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 17 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 17 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 16 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 16 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 15 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 15 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 14 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 14 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 13 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 13 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 12 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 12 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 11 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 11 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 10 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 10 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 9 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 9 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 8 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 8 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 7 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 7 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 6 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 6 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 5 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 5 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 4 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 4 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 3 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 3 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 2 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 1 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 0 ],
					"hidden" : 1,
					"order" : 0,
					"source" : [ "obj-6", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-78", 0 ],
					"hidden" : 1,
					"source" : [ "obj-76", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-81", 0 ],
					"hidden" : 1,
					"source" : [ "obj-78", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-55", 0 ],
					"hidden" : 1,
					"source" : [ "obj-81", 0 ]
				}

			}
 ],
		"dependency_cache" : [ 			{
				"name" : "brushes.aif",
				"bootpath" : "C74:/media/msp",
				"type" : "AIFF",
				"implicit" : 1
			}
, 			{
				"name" : "cello-f2.aif",
				"bootpath" : "C74:/media/msp",
				"type" : "AIFF",
				"implicit" : 1
			}
, 			{
				"name" : "connection.js",
				"bootpath" : "~/Documents/Max 9/Packages/nn_terrain/help",
				"patcherrelativepath" : "../../../Documents/Max 9/Packages/nn_terrain/help",
				"type" : "TEXT",
				"implicit" : 1
			}
, 			{
				"name" : "nn~.mxo",
				"type" : "iLaX"
			}
 ],
		"autosave" : 0
	}

}
