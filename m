Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0892617BD6;
	Mon, 23 Sep 2024 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727122862; cv=none; b=arTM26TkVThkFMETKzGX6aV1UDWUQW2xk8vn117UA0rwH/3TwLPVYHfDEnk9PTbfjlkQ+yaG0nLjk/WKBsip/U0jbZaLIJrpkLXkrC+dIHR8rM3F8WR9J5RLRdnQ3osvIScGRqGHwn1bNe1EofV5QkYIBYdNcOQFdmCSaKiOPy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727122862; c=relaxed/simple;
	bh=DsCb6qpLdEgMJ5yT5bmM7oaMBnnki7ouT3XEgyQdChw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jK+D+x3EGcQpidD4loIxGb7IL/pg7YlvuFxH8lp4obQNcfl42PQ3wX4+CevoCbBMrnLgMZSltHyvYweN7nvmeSM6TLwZ70GlV2juC8vksSFkjMzFod8sUgm7TBFzzzB1D8DqW3kM1LhNSLTH+XERPVlOfDxlUF2ocHv8cvK5an4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8dP5Sxm; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8dP5Sxm"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53653ee23adso4311598e87.3;
        Mon, 23 Sep 2024 13:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727122859; x=1727727659; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NleUZATndt1acwKzBa7y/6tS+SaA3XdbIXpdmDlWmuM=;
        b=g8dP5SxmiPkjc+0n4D/XORa/w4P9M4D6RxGuayiUkXZvareJ07e9FWp5M96ncLdXOn
         J/ipV+fIzNqOoAS3GLs7GVFOnoFx0toIdaXmqmi48ddMZLUMOwft8gpXwargO/lnX3DI
         PbdUFcaC5gYk9wRzrNADQwWSKwLc4q4zq04/1ODFdnbCMTL7bPTee454OiVWE9UoJwgB
         30ZalrrnC1K37Y5z5UuZq5ofHboWzf8QsCqYGcnMKFSbb9sI7XrclM9hmB5p9uXLQtxX
         euEyXnkdu73Nff98saKDmuFcgzcpJVMLf2ZZyZVndyYCehHr99DKLGGriVAXvUxewDRr
         Qiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727122859; x=1727727659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NleUZATndt1acwKzBa7y/6tS+SaA3XdbIXpdmDlWmuM=;
        b=JBGWkdSMzhKZXAxaF7j2soAh3B1V6//CAVZxeeYUssKeLz2jCU6ovTboNYQoj8F2ng
         Ed5vsiF2yUzD6GWpv8xWfi+Xq6j6BYhKdfscDiRtA8gUViH8Z2JsR7WtDteIEzUMdcCJ
         OamqHdRnnay2MK5Y33P/1V/1a0m6U3JTzRn7hRBZDI9aXVEFqIwyJzf4EhARofl+L99r
         uoJSl5obpB590rIUU7kRSQWclturNkapN60LYGKIGtVd/ChbQJi4HGOrlCqKRKO6tPHn
         MAXqTIX9oi5+/LImlRxw2nSS73/lsGHiKZ+QFHVo69QDUiVZ+H2J2qZlfRSvfcVgbKEQ
         +kLg==
X-Forwarded-Encrypted: i=1; AJvYcCUjhJLEbSUdKvhzkocDaZCstKNe7I68DZ4CE9iA78aAthNUKmZLJVBLxzhyGnp6QPuejKAi9A==@lists.linux.dev, AJvYcCWaaKJnoTrnv8ly26HO7gKX9/Zu7Xm10C7pDvmZFdcWuUOWzrTBRzhonGsJMuJTo92M0s2S3A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZNglBsEPSL6AjtwGGuOHoe0dXfd2On8gujOlsV2Kjj2F6WlgD
	+F+dp4C8QHRa7qsbpDngyp4VdEPFS/NfXQVRocb2hWwgJ8cI42RwOCzpLe12/s9SmU3354Lp0BN
	G/b8X2WvFgo+qgNKi61k7VmIMjyY=
X-Google-Smtp-Source: AGHT+IFe6pzcf17Wh1gjew0V8YTIVeE9hLlPHLiePqr1rh/borgYiDBhQWNwMIzi8TlRjg6PaEMoWqREOxcDUAURZmM=
X-Received: by 2002:a05:6512:6c3:b0:535:63a3:c7d1 with SMTP id
 2adb3069b0e04-536ad3b7f23mr6933488e87.48.1727122858742; Mon, 23 Sep 2024
 13:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240814203850.2240469-20-dhowells@redhat.com>
 <20240923183432.1876750-1-chantr4@gmail.com> <912766.1727120313@warthog.procyon.org.uk>
In-Reply-To: <912766.1727120313@warthog.procyon.org.uk>
From: Manu Bretelle <chantr4@gmail.com>
Date: Mon, 23 Sep 2024 13:20:47 -0700
Message-ID: <CAArYzrL0+tiPRhW6Z5fDp4WJgxVBeMg90A44rA=htXku0Q99eQ@mail.gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
To: David Howells <dhowells@redhat.com>
Cc: asmadeus@codewreck.org, ceph-devel@vger.kernel.org, christian@brauner.io, 
	ericvh@kernel.org, hsiangkao@linux.alibaba.com, idryomov@gmail.com, 
	jlayton@kernel.org, linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	marc.dionne@auristor.com, netdev@vger.kernel.org, netfs@lists.linux.dev, 
	pc@manguebit.com, smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	v9fs@lists.linux.dev, willy@infradead.org, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 12:38=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
>
> Hi Manu,
>
> Are you using any other network filesystem than 9p, or just 9p?

Should be 9p only.

We ended up reverting the whole merge with
https://patch-diff.githubusercontent.com/raw/kernel-patches/vmtest/pull/288=
.patch
as my initial commit revert happened to work because of the left over
cached .o.

FWIW, I quickly checked and virtiofs is not affected. e.g is I was to
apply https://github.com/danobi/vmtest/pull/88 to vmtest and recompile
the kernel with:
  CONFIG_FUSE_FS=3Dy
  CONFIG_VIRTIO_FS=3Dy
  CONFIG_FUSE_PASSTHROUGH=3Dy

qemu-system-x86_64 "-nodefaults" "-display" "none" \
  "-serial" "mon:stdio" "-enable-kvm" "-cpu" "host" \
  "-qmp" "unix:/tmp/qmp-895732.sock,server=3Don,wait=3Doff" \
  "-chardev" "socket,path=3D/tmp/qga-733184.sock,server=3Don,wait=3Doff,id=
=3Dqga0" \
  "-device" "virtio-serial" \
  "-device" "virtserialport,chardev=3Dqga0,name=3Dorg.qemu.guest_agent.0" \
  "-object" "memory-backend-memfd,id=3Dmem,share=3Don,size=3D4G" "-numa"
"node,memdev=3Dmem" \
  "-device" "virtio-serial" "-chardev"
"socket,path=3D/tmp/cmdout-713466.sock,server=3Don,wait=3Doff,id=3Dcmdout" =
\
  "-device" "virtserialport,chardev=3Dcmdout,name=3Dorg.qemu.virtio_serial.=
0" \
  "-chardev" "socket,id=3Droot,path=3D/tmp/virtiofsd-807478.sock" \
  "-device" "vhost-user-fs-pci,queue-size=3D1024,chardev=3Droot,tag=3Drootf=
s" \
  "-kernel" "/data/users/chantra/linux/arch/x86/boot/bzImage" \
  "-no-reboot" "-append" "rootfstype=3Dvirtiofs root=3Drootfs rw
earlyprintk=3Dserial,0,115200 printk.devkmsg=3Don console=3D0,115200
loglevel=3D7 raid=3Dnoautodetect init=3D/tmp/vmtest-initBdg4J.sh panic=3D-1=
" \
  "-chardev" "socket,id=3Dshared,path=3D/tmp/virtiofsd-992342.sock" \
  "-device" "vhost-user-fs-pci,queue-size=3D1024,chardev=3Dshared,tag=3Dvmt=
est-shared"
\
  "-smp" "2" "-m" "4G"

would work.

Manu

>
> David
>
