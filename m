Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1980F823C8;
	Mon, 23 Sep 2024 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727116503; cv=none; b=NMnixCTzOr8DBD1tzK2siO9tASJID80E+fUlz3TgVeKoU3WSyA5abz6Y1TaPSY1KkURcceQYh+ZJt6PCGePPdCyKs/G3Y9t/LefzdZejkV6GXGgkgR8R/lEJEuwVo0MXjAXa+9x+TCPh4IXa/Vp+65yasRxJofd21vDcAM29nko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727116503; c=relaxed/simple;
	bh=RKX5fFXoGLb5zuDBXhdYVsPbUnLmox4g9PwyHy+lMJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6ta/qSZVzaMlGqDDx87Z0A8en1m+rqX22klUyAOzDdwcVrUy5q0Z0zewJE0Ci5Vhl2XziHduLAB/9cMFRBFqlNfeW1IjVedVof5IT1eUaX2tjoCEbJJpCCtXthij+5p9sU6hfXL68cGog49cfb/rVF9m/+7qFJ0KSpIRKM4VPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BX2j/MXH; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BX2j/MXH"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-710d8cab1c3so3571018a34.0;
        Mon, 23 Sep 2024 11:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727116501; x=1727721301; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IU1aoQ8nAToYML3G712UX67gK+ebjEKMmSqhwWIOXRU=;
        b=BX2j/MXH9qAd9zX91nW8BHYwdxdrGTV+nwoksqDKE3etYdZ6Y7GPYRfqsNMNmI1ec/
         uOCas88r798kI8goyDLgUE8R1SbBMj7aKa9ohYXLCqaTAIYYq/AUcOYeRwTxinhroYLX
         gtmLJOqUtEG7z+zwh2GO7Z5e/8xpaOPeJj9A2HQnc2XpCA6jcEf7/nkYAIPA5MkGGvvX
         4ZthaVvKSpxKwWZhKReo5vv1iPXQex2nZ60GO34Mi1Jtxo+UUQJn890wgt4D6ywLl3TF
         XUiTMgCHDlHlR4SJR4rzoljrDcj1vzAyLb1Kbsz7exxO/+9tDMAOLovnBbNImkUcpqVi
         2+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727116501; x=1727721301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IU1aoQ8nAToYML3G712UX67gK+ebjEKMmSqhwWIOXRU=;
        b=vcVucvspg/6w9uIDNkc8Lg1jRGPWHydpxcQlsVfbR6ylZCXExnCd32U7+8610/rQGH
         slRvKGnOgoy3JzyKnseKWW+4BFoRZhSqqManncSe8OHEmwa69SNUUv8p/Mv8zgpqrkrv
         Ln8QBHYMiY5dlkwfNFbeJhPYhHUitOT4Mkic4nRPIrFMbmzXY40pfEZaI2/VOrgmMBxU
         ZLk6iCBJXbwFO29Xs7vPwodcIwTqvwrG8MPedR2WiWZ9cVh0Qn4sLWpv0IGoShoSrlEw
         7Q6YXicInMrSiGD6cKCoJMMB09GVvPADTa7pO7cXG64kZLQlj49TINoVTdkXk7rJasRT
         fqmA==
X-Forwarded-Encrypted: i=1; AJvYcCW/5z9iu9Wija+VYYaWnXixckOgBv2skrOpbAqUaYaAsPkCS17zoaJuDoU8aVDwOA6EW+Btjg==@lists.linux.dev, AJvYcCW85awQvLdkdmfgv7uLOg5G2Rx4B0eV0ninxCLOGEfF4knKqobxjB2i0sIv15IlSwPDDl24KQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVRaFjmXkD75R4nYbZLdLaxszBoJYtrIiEBW/KrnqZSFKCa0dL
	j0HVmec6d58cx4fhV39VSGH2TOAfxgRPh24pwXwER3lcDG8PiEMv
X-Google-Smtp-Source: AGHT+IFvgEYijirg/eXLBYiD5dxcd0Zmc+d70nalPrLG/FqXhYvz1aSQ8Ig7QbHNJjxjsN+QDuXf8g==
X-Received: by 2002:a05:6830:3891:b0:703:6076:a47 with SMTP id 46e09a7af769-71393533f16mr8751528a34.23.1727116501003;
        Mon, 23 Sep 2024 11:35:01 -0700 (PDT)
Received: from localhost (fwdproxy-vll-115.fbsv.net. [2a03:2880:12ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e3b0d94409sm3611397eaf.18.2024.09.23.11.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 11:34:59 -0700 (PDT)
From: Manu Bretelle <chantr4@gmail.com>
To: dhowells@redhat.com
Cc: asmadeus@codewreck.org,
	ceph-devel@vger.kernel.org,
	christian@brauner.io,
	ericvh@kernel.org,
	hsiangkao@linux.alibaba.com,
	idryomov@gmail.com,
	jlayton@kernel.org,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-nfs@vger.kernel.org,
	marc.dionne@auristor.com,
	netdev@vger.kernel.org,
	netfs@lists.linux.dev,
	pc@manguebit.com,
	smfrench@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	v9fs@lists.linux.dev,
	willy@infradead.org,
	eddyz87@gmail.com
Subject: [PATCH v2 19/25] netfs: Speed up buffered reading
Date: Mon, 23 Sep 2024 11:34:32 -0700
Message-ID: <20240923183432.1876750-1-chantr4@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240814203850.2240469-20-dhowells@redhat.com>
References: <20240814203850.2240469-20-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David,


It seems this commit (ee4cdf7ba857: "netfs: Speed up buffered reading") broke
booting vms using qemu. It still reproduces on top of linux-master.

BPF CI has failed to boot kernels with the following trace [0]. Bisect narrowed
it down to this commit.
Reverting ee4cdf7ba857 on to of current bpf-next master with [1] (basically
ee4cdf7ba857 where I had to manually edit some conflict to the best of my
uneducated knowledge) gets qemu boot back on track.

This can be reproed by following the build steps in [2]. Assuming danobi/vmtest
[3] is already installed, here is the script used during bisect.

  #!/bin/bash
  cat tools/testing/selftests/bpf/config{,.$(uname -m),.vm} > .config
  make olddefconfig
  make -j$((4* $(nproc))) || exit 125
  timeout 10 vmtest -k $(make -s image_name) "echo yeah"
  exit $?

The qemu command invoked by vmtest is:

qemu-system-x86_64 "-nodefaults" "-display" "none" "-serial" "mon:stdio" \
  "-enable-kvm" "-cpu" "host" "-qmp" "unix:/tmp/qmp-971717.sock,server=on,wait=off" \
  "-chardev" "socket,path=/tmp/qga-888301.sock,server=on,wait=off,id=qga0" \
  "-device" "virtio-serial" \
  "-device" "virtserialport,chardev=qga0,name=org.qemu.guest_agent.0" \
  "--device" "virtio-serial" \
  "-chardev" "socket,path=/tmp/cmdout-508724.sock,server=on,wait=off,id=cmdout" \
  "--device" "virtserialport,chardev=cmdout,name=org.qemu.virtio_serial.0" \
  "-virtfs" "local,id=root,path=/,mount_tag=/dev/root,security_model=none,multidevs=remap" \
  "-kernel" "/data/users/chantra/linux/arch/x86/boot/bzImage" \
  "-no-reboot" "-append" "rootfstype=9p rootflags=trans=virtio,cache=mmap,msize=1048576 rw earlyprintk=serial,0,115200 printk.devkmsg=on console=0,115200 loglevel=7 raid=noautodetect init=/tmp/vmtest-init4PdCA.sh panic=-1" \
  "-virtfs" "local,id=shared,path=/data/users/chantra/linux,mount_tag=vmtest-shared,security_model=none,multidevs=remap" \
  "-smp" "2" "-m" "4G"


[0] https://gist.github.com/chantra/683d9d085c28b7971bbc6f76652c22f3
[1] https://gist.github.com/chantra/642868407d10626fd44febdfed0a4fce
[2] https://chantra.github.io/bpfcitools/bpf-local-development.html#building-a-vm-friendly-kernel-for-bpf
[3] https://github.com/danobi/vmtest
