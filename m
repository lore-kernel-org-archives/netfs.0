Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD17C199944;
	Mon, 23 Sep 2024 18:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727117004; cv=none; b=ASNmBQX3Jw2I1KpuhUlNs0HyrGcCZbEti1sm4ZHPygKHsjhioCTpvomVPCtcP7dIwtul7dM8DWejupJmtVefCRP3Y0gad7hdPewwx5PVkYkAZjydXPiYlgu0sBhuDpUd7Xr3ZGhCNvNJhoj6XvRSTVjoAl20sNVCizPK06Gp6aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727117004; c=relaxed/simple;
	bh=Ol+EJm8cLxGdf9CbM3fpYT3el5UIktI0aEYJ4EQMVP0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DFkmixKBVPEjXE73aA0RXcc/H+JEPSBNp84c5JGTex1Wk19wwX5bsjkFj4HRuD0jtGTeghURnFx/TKvAynjN4SeOOSCv/RNw/VeKUiOA5KTWsuM7pn0Jtf97RejFPqQwqgIDqSZqARqoysFYp1HStGYIHeTKj0cVYT2z88WPdXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gb6UBb98; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb6UBb98"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-205909afad3so53630715ad.2;
        Mon, 23 Sep 2024 11:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727117002; x=1727721802; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2LHmjzXAtMIZmJ5Rn7lQK9rTwNZYqrEZiN8cZ0JMhp8=;
        b=Gb6UBb98LYEgHQNT3nBqf8g4buZUUF6FtQCS/AkIjBj9Nw4J9vGF0HpgmWGppeUUlg
         WOwXMF7xyJoGrukuItz6iKpZRAavd9JQKUfyEXZpagKl2TNeXMks/t3i8U8g82UCkwut
         /+L7QPM9DurvnFJGvZZkbB7adSqw4iHHlgZ8FUXfid8xtq1vZEDUJlVPBKW9vuT38CKu
         MW6KVPqdUrW7sjRrhZhpdA8O/i1G+zFDnEza657xOfamKi3gIZG5SpSmYRLxGmpiT4os
         0j2gEn0HtxZBlHUnK06CACLHTCQDHfkPVZJMa73Qmc4vGMsvFrDuhhGNI4J0zcuabhiH
         2PWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727117002; x=1727721802;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2LHmjzXAtMIZmJ5Rn7lQK9rTwNZYqrEZiN8cZ0JMhp8=;
        b=OqnaNcYAFngl/gnLz5ONdM1GrLfdR6R3HftFzq1t8S/Gf2jHMhfxUE9kunDBHzziBs
         0OIXqluNjxY2psPV4/+Z99gnNnMt4xxkwUh0TmwNT2RA6N5sjj9vLDyIe7XMVRi3rMIH
         LfayZxnQlAmxHBWRdKBjIux0sva2PrKhZfkLUQ6S0CJyiQCM5zAhqRiWGmviCZAS+jIV
         KaXdfb193xI8Ny/WhAfK4eclDbQArhkAI66z0y1u7ck54X++Qtx56N+Qohdfcp8O2rWP
         MOCtmDjWAjAr0Q/DB4WhzOFZfy9LsC1PlbaQvVaYjgojw98YIuc8PI9tnqjVsMjjBF15
         nklw==
X-Forwarded-Encrypted: i=1; AJvYcCVUDaAEz+WWnoIxqzewfouQhBxgqhTc1I1xtzecS8xFtAe6K+25HaWn9cEFFKZHCNngVlyU7g==@lists.linux.dev, AJvYcCXBoCfZxQEZkQ+e0gUYrPTe0VePnR062Q7NxPTKeRJTCaxn/XW1lCNzjrSfgtOKOuRLNhWatA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3VsbVBRxMXCHQl8zfbTjNGN8MSJSb5TnncowTFXFPQyoHtElW
	G9GSfLo6sJpnuXlNTSO7Ooc2Kd5c1AfHHmq6LCMkVzM+eDtBQkgx
X-Google-Smtp-Source: AGHT+IHPhZrggldPhDzAISSCt7hDQP+r1zqFPPuYtS+By/R474KzhLZIXK5fLtO4N5rEH3YS+YNQYw==
X-Received: by 2002:a17:902:ecc2:b0:207:3fd0:13ec with SMTP id d9443c01a7336-208d836cef7mr234528045ad.17.1727117002177;
        Mon, 23 Sep 2024 11:43:22 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794601008sm135317725ad.81.2024.09.23.11.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 11:43:21 -0700 (PDT)
Message-ID: <670794146059f85a30efd7cf9d6650375d987077.camel@gmail.com>
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
Date: Mon, 23 Sep 2024 11:43:16 -0700
In-Reply-To: <20240923183432.1876750-1-chantr4@gmail.com>
References: <20240814203850.2240469-20-dhowells@redhat.com>
	 <20240923183432.1876750-1-chantr4@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Mon, 2024-09-23 at 11:34 -0700, Manu Bretelle wrote:

[...]

> The qemu command invoked by vmtest is:
>=20
> qemu-system-x86_64 "-nodefaults" "-display" "none" "-serial" "mon:stdio" =
\
>   "-enable-kvm" "-cpu" "host" "-qmp" "unix:/tmp/qmp-971717.sock,server=3D=
on,wait=3Doff" \
>   "-chardev" "socket,path=3D/tmp/qga-888301.sock,server=3Don,wait=3Doff,i=
d=3Dqga0" \
>   "-device" "virtio-serial" \
>   "-device" "virtserialport,chardev=3Dqga0,name=3Dorg.qemu.guest_agent.0"=
 \
>   "--device" "virtio-serial" \
>   "-chardev" "socket,path=3D/tmp/cmdout-508724.sock,server=3Don,wait=3Dof=
f,id=3Dcmdout" \
>   "--device" "virtserialport,chardev=3Dcmdout,name=3Dorg.qemu.virtio_seri=
al.0" \
>   "-virtfs" "local,id=3Droot,path=3D/,mount_tag=3D/dev/root,security_mode=
l=3Dnone,multidevs=3Dremap" \
>   "-kernel" "/data/users/chantra/linux/arch/x86/boot/bzImage" \
>   "-no-reboot" "-append" "rootfstype=3D9p rootflags=3Dtrans=3Dvirtio,cach=
e=3Dmmap,msize=3D1048576 rw earlyprintk=3Dserial,0,115200 printk.devkmsg=3D=
on console=3D0,115200 loglevel=3D7 raid=3Dnoautodetect init=3D/tmp/vmtest-i=
nit4PdCA.sh panic=3D-1" \
>   "-virtfs" "local,id=3Dshared,path=3D/data/users/chantra/linux,mount_tag=
=3Dvmtest-shared,security_model=3Dnone,multidevs=3Dremap" \
>   "-smp" "2" "-m" "4G"

fwiw: removing "cache=3Dmmap" from "rootflags" allows VM to boot and run te=
sts.

