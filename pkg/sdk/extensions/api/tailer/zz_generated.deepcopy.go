//go:build !ignore_autogenerated
// +build !ignore_autogenerated

// Copyright © 2020 Banzai Cloud
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Code generated by controller-gen. DO NOT EDIT.

package tailer

import (
	"github.com/cisco-open/operator-tools/pkg/types"
)

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *General) DeepCopyInto(out *General) {
	*out = *in
	if in.ContainerBase != nil {
		in, out := &in.ContainerBase, &out.ContainerBase
		*out = new(types.ContainerBase)
		(*in).DeepCopyInto(*out)
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new General.
func (in *General) DeepCopy() *General {
	if in == nil {
		return nil
	}
	out := new(General)
	in.DeepCopyInto(out)
	return out
}
