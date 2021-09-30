
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"data","type":"Data"},{"name":"CID","title":"Rater ID","type":"Variable","suggested":["nominal","id"],"permitted":["factor","id"]},{"name":"CaID","title":"Case ID","type":"Variable","suggested":["nominal","id"],"permitted":["factor","id"]},{"name":"vals","title":"Values","type":"Variables"},{"name":"level","title":"Measure type","type":"List","options":[{"title":"Nominal","name":"nominal"},{"title":"Ordinal","name":"ordinal"},{"title":"Interval","name":"interval"},{"title":"Ratio","name":"ratio"}],"default":"nominal"},{"name":"rat","title":"Raters","type":"Bool","default":false},{"name":"cas","title":"Cases","type":"Bool","default":false}];

const view = function() {
    
    this.handlers = { }

    View.extend({
        jus: "3.0",

        events: [

	]

    }).call(this);
}

view.layout = ui.extend({

    label: "Krippendorff's Alpha",
    jus: "3.0",
    type: "root",
    stage: 0, //0 - release, 1 - development, 2 - proposed
    controls: [
		{
			type: DefaultControls.VariableSupplier,
			typeName: 'VariableSupplier',
			persistentItems: false,
			stretchFactor: 1,
			controls: [
				{
					type: DefaultControls.TargetLayoutBox,
					typeName: 'TargetLayoutBox',
					label: "Rater ID",
					controls: [
						{
							type: DefaultControls.VariablesListBox,
							typeName: 'VariablesListBox',
							name: "CID",
							maxItemCount: 1,
							isTarget: true
						}
					]
				},
				{
					type: DefaultControls.TargetLayoutBox,
					typeName: 'TargetLayoutBox',
					label: "Case ID",
					controls: [
						{
							type: DefaultControls.VariablesListBox,
							typeName: 'VariablesListBox',
							name: "CaID",
							maxItemCount: 1,
							isTarget: true
						}
					]
				},
				{
					type: DefaultControls.TargetLayoutBox,
					typeName: 'TargetLayoutBox',
					label: "Values",
					controls: [
						{
							type: DefaultControls.VariablesListBox,
							typeName: 'VariablesListBox',
							name: "vals",
							isTarget: true
						}
					]
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			controls: [
				{
					type: DefaultControls.ComboBox,
					typeName: 'ComboBox',
					name: "level"
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			controls: [
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Additional Information"
				},
				{
					type: DefaultControls.CheckBox,
					typeName: 'CheckBox',
					name: "rat"
				},
				{
					type: DefaultControls.CheckBox,
					typeName: 'CheckBox',
					name: "cas"
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
