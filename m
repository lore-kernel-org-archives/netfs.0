Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C75118027;
	Mon, 23 Sep 2024 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727128569; cv=none; b=AVK0vpZP0013PY0SO6YC6UKNr3HL8Bixyjo7fjCMXq1Ie/V9JX41yE45pQd0q/Gx6qiI7/owuH7/oU0tlZqXvx4bxfLzO7wWEjhOMsBm8k7SmOXXPUtg2AsJ0K1AmaPEYWE//GYWOpvja8DdpNqKbKn8V6+aRcR6+Nfy9ZotahE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727128569; c=relaxed/simple;
	bh=0MkE1EZsDQcuj7jFg9i94IepmQpIfftjB4itHJtXX2k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kRxobIit9BVsKjzSaQpqmUu6HesfuqvaQ7csdSW/ECBnaoNdI53mVxgog4DE4A3Op2wQ17h0lgDgxgaBMZZ/IipGlneHjpsCsP+gq5+jA4lVIhlAXFvgiHfOlZTRbFt2fmk/6oR8Sh8FCNrQ5x5Cnz9nGB9ZwAEghZ1Ysoa0q/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5FiaRRE; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5FiaRRE"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7d666fb3fb9so2323959a12.0;
        Mon, 23 Sep 2024 14:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727128567; x=1727733367; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/8+/Agj95n5lwYDiAPqDI5W15t31UBn8yUoG9/0FMeE=;
        b=d5FiaRREOhcDTwZCucHkt/Tq6G58Eojws6NmyR5On/w+hHAFs3EUk7KiDGJPgJ9Gfe
         Xwvznrg1BDll9KfnL8xeZaUyILnVgJxQx9VOm/0m2PA4jDBXP6G06s/3SPg0rzMlFOL5
         Rt1hGV/dfZ3QOohSVrFZ+tgs1C+A8RGKKKIsWqdVB2N5UACrRX68LbqAnpbIFTOl1bOY
         V5KwjQsiRmwEmOFgsVunBHxRPOKY86+58nZGgiYRj24Qi6JPNMBZzkLxJckscX4j6xbn
         sW0lk3da6hQnxwF7mmxZOpheYt51Q52yBSNMqb5s7FD2oQYf2IfE52wZe82kqGTpbK76
         ekVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727128567; x=1727733367;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8+/Agj95n5lwYDiAPqDI5W15t31UBn8yUoG9/0FMeE=;
        b=I+zbqkUhoSffrws3yk4co0c99UKMFoLZ7D1lDhyRVRHIlCfnlA9rQhFXBT7cRbpNWm
         9bAZ1e0zbHHYZSAu8j0E4rrmvzDuDa+50alGjLbAiJPA9t9kR592nVz1A2cA597vK58H
         /5KlU2gR15xvFsVT42/JZl1ZmeZbuXOJlGZFR/KH9CAj+aQWyNkcMLzY12B9m5qzBEa5
         FSV6DOsnzi8P8x3qFBLBr3SjeekV3vqJdOM8o55/UreDwSuWhWffco7fuEOF67wGLZGq
         yVeFNDep/ZHER75QiAT51igQO6fWdxBr/MNWRWwpL3GPFWr4bBg0ZW7iNmXsmAQleUPh
         5n9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUW0PZSc30A3B/zzC+Zp6olPS/uAae0mR2YPfAjM08Cn8Xom84OGwoGFIrgFNMQkKTmltNVvg==@lists.linux.dev, AJvYcCUimbbgHDvRN7K70y7u29s8bN9WUWizAa9YTYJPb5YWLWpGeqhkwe4F4ns+Vg6ymNrqU2P5nQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6HETiaeILL8mr6MToIOySjfgZNhBpyYUGtl1ACrE1CLKhLjpS
	FWKbth3yU7V36Y8f+uQ8OQPoBGLAQp5XxEH6mpI58vlGPh1OhkB9
X-Google-Smtp-Source: AGHT+IEOWgP+NQYRnWmQn7Tzm3qkB8mabtnbmT8Onpp+Lt2mGQXJbIgQdAxRKso0U9c6JGKqTdiPZA==
X-Received: by 2002:a05:6a21:3983:b0:1d2:e90a:f4aa with SMTP id adf61e73a8af0-1d343c5913dmr1421967637.13.1727128567376;
        Mon, 23 Sep 2024 14:56:07 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc97c102sm80715b3a.154.2024.09.23.14.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 14:56:06 -0700 (PDT)
Message-ID: <0f6afef57196cb308aa90be5b06a64793aa24682.camel@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
From: Eduard Zingerman <eddyz87@gmail.com>
To: Manu Bretelle <chantr4@gmail.com>, dhowells@redhat.com
Cc: asmadeus@codewreck.org, ceph-devel@vger.kernel.org,
 christian@brauner.io,  ericvh@kernel.org, hsiangkao@linux.alibaba.com,
 idryomov@gmail.com,  jlayton@kernel.org, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org,  linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-nfs@vger.kernel.org,  marc.dionne@auristor.com,
 netdev@vger.kernel.org, netfs@lists.linux.dev,  pc@manguebit.com,
 smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
 v9fs@lists.linux.dev, willy@infradead.org
Date: Mon, 23 Sep 2024 14:56:01 -0700
In-Reply-To: <670794146059f85a30efd7cf9d6650375d987077.camel@gmail.com>
References: <20240814203850.2240469-20-dhowells@redhat.com>
	 <20240923183432.1876750-1-chantr4@gmail.com>
	 <670794146059f85a30efd7cf9d6650375d987077.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Mon, 2024-09-23 at 11:43 -0700, Eduard Zingerman wrote:
> On Mon, 2024-09-23 at 11:34 -0700, Manu Bretelle wrote:
>=20
> [...]
>=20
> > The qemu command invoked by vmtest is:
> >=20
> > qemu-system-x86_64 "-nodefaults" "-display" "none" "-serial" "mon:stdio=
" \
> >   "-enable-kvm" "-cpu" "host" "-qmp" "unix:/tmp/qmp-971717.sock,server=
=3Don,wait=3Doff" \
> >   "-chardev" "socket,path=3D/tmp/qga-888301.sock,server=3Don,wait=3Doff=
,id=3Dqga0" \
> >   "-device" "virtio-serial" \
> >   "-device" "virtserialport,chardev=3Dqga0,name=3Dorg.qemu.guest_agent.=
0" \
> >   "--device" "virtio-serial" \
> >   "-chardev" "socket,path=3D/tmp/cmdout-508724.sock,server=3Don,wait=3D=
off,id=3Dcmdout" \
> >   "--device" "virtserialport,chardev=3Dcmdout,name=3Dorg.qemu.virtio_se=
rial.0" \
> >   "-virtfs" "local,id=3Droot,path=3D/,mount_tag=3D/dev/root,security_mo=
del=3Dnone,multidevs=3Dremap" \
> >   "-kernel" "/data/users/chantra/linux/arch/x86/boot/bzImage" \
> >   "-no-reboot" "-append" "rootfstype=3D9p rootflags=3Dtrans=3Dvirtio,ca=
che=3Dmmap,msize=3D1048576 rw earlyprintk=3Dserial,0,115200 printk.devkmsg=
=3Don console=3D0,115200 loglevel=3D7 raid=3Dnoautodetect init=3D/tmp/vmtes=
t-init4PdCA.sh panic=3D-1" \
> >   "-virtfs" "local,id=3Dshared,path=3D/data/users/chantra/linux,mount_t=
ag=3Dvmtest-shared,security_model=3Dnone,multidevs=3Dremap" \
> >   "-smp" "2" "-m" "4G"
>=20
> fwiw: removing "cache=3Dmmap" from "rootflags" allows VM to boot and run =
tests.
>=20

A few more details:
- error could be reproduced with KASAN enabled, log after
  scripts/decode_stacktrace.sh post-processing is in [1];
  (KASAN reports use-after-free followed by null-ptr-deref);
- null-ptr-deref is triggered by access to page->pcp_list.next
  when list_del() is called from page_alloc.c:__rmqueue_pcplist(),
  e.g. the following warning is triggered if added:

  --- a/mm/page_alloc.c
  +++ b/mm/page_alloc.c
  @@ -2990,6 +2990,7 @@ struct page *__rmqueue_pcplist(struct zone *zone, u=
nsigned int order,
                  }
=20
                  page =3D list_first_entry(list, struct page, pcp_list);
  +               WARN_ONCE(!page->pcp_list.next, "!!!!! page->pcp_list.nex=
t is NULL\n");
                  list_del(&page->pcp_list);
                  pcp->count -=3D 1 << order;
          } while (check_new_pages(page, order));
- config used for testing is [2];
- kernel used for testing is [3];

[1] https://gist.github.com/eddyz87/e638d67454558508451331754f946f41
[2] https://gist.github.com/eddyz87/f2c9c267db20ee53a6eb350aba0d2182
[3] de5cb0dcb74c ("Merge branch 'address-masking'")
    https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
